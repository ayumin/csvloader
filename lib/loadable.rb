# -*- encoding: utf8 -*-
module Loadable
  def execute(ary)
    @recordset = normalize(import(ary))
  end
  # CSVからインポートしたデータを加工してHashの配列にして返す。
  def import(ary)
    row_header = nil
    row_data = []
    ary.each_with_index do |row,row_index|
      row_header ||= row.map(&:to_sym)
      next if row_index == 0 or row.join.length == 0
      row_hash = {}
      row.each_with_index do |col,col_index|
        row_hash[row_header[col_index]] = col ? convert(col,row_header[col_index]) : nil
      end
      row_data << row_hash
    end
    row_data
  end
  # importで加工されたHash配列を正規化する。
  # サブクラスでオーバーライドされない場合はサブクラスのクラス名
  # からデータ投入先のテーブル名を推測する。
  def normalize(data = [])
    {self.class.to_s.sub(/Loader$/,'') => data}
  end
  def insert
    ActiveRecord::Base.transaction do
      @recordset.each_pair do |k,v|
        v.each {|record| k.constantize.create(record)}
      end
    end
  end
  private
  # CSVヘッダの命名規約にしたがってカラムの値を変換して返す
  def convert(val,key)
    key.to_s =~ /_[a-zA-Z]+?$/
    case $&
    when '_date'
      (month,day,year) = val.split('/').map(&:to_i)
      Date.new(year,month,day)
    when '_at'
      (month,day,year,hour,min,sec) = val.split(/[\/: ]/).map(&:to_i)
      DateTime.new(year,month,day,hour,min,sec)
    when '_md','_rate','_f'
      val.to_f
    when '_id','_no','_num','_days'
      val.to_i
    else
      val
    end
  end
end
