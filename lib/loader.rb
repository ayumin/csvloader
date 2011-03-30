# -*- encoding: utf8 -*-
require 'fastercsv'
module Loader
  def import(path)
    @header = []
    @data = []
    FasterCSV.read(path).each_with_index do |row,row_index|
      @header = row.map(&:to_sym) if row_index == 0
      row_hash = {}
      next if row_index == 0 or row.join.length == 0
      row.each_with_index do |col,col_index|
        row_hash[@header[col_index]] = convert(col,@header[col_index])
      end
      @data << row_hash
    end
    @data
  end
  private
  def convert(val,key)
    if val
      case key.to_s
      when /_date$/
        (month,day,year) = val.split('/').map(&:to_i)
        Date.new(year,month,day)
      when /_at$/
        (month,day,year,hour,min,sec) = val.split(/[\/: ]/).map(&:to_i)
        DateTime.new(year,month,day,hour,min,sec)
      when /(_md|_rate)$/
        val.to_f
      when /(_id|_no|_num|_days)$/
        val.to_i
      else
        val
      end
    else
      nil
    end
  end
end
