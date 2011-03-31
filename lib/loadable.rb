# -*- encoding: utf8 -*-
module Loadable
  def execute(args)
    init
    import(args)
    params = normalize
    begin
      ActiveRecord::Base.transaction do
        insert(params)
      end
    rescue
    end
  end
  def inint(opts = {})
  end
  def import(str)
    row_data = []
    str.each_line.with_index do |row,row_index|
      row_header || = row.map(&:to_sym)
      next if row_index == 0 or row.join.length == 0
      row_hash = {}
      row.each_with_index do |col,col_index|
        row_hash.merge({ row_header[col_index] => (col ? convert(col,row_header[col_index]) : nil)})
      end
      row_data << row_hash
    end
    row_data
  end
  def normalize(data = [])
    {self.class.to_s.sub(/Loader$/,'') => data}
  end
  def insert(params)
    params.each_keys do |key|
      table = key.constantize
      create(params[key]).each do |row|
        table.create(row)
      end
    end
  end
  private
  def convert(val,key)
    return {key => val} unless val
    key.to_s =~ /_[a-zA-Z]+?$/
    converted_val = case $&
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
    {key => converted_val}
  end
end
