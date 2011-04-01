# -*- encoding: utf-8 -*-
require 'fastercsv'
class CSVLoader
  include Loadable
  class << self
    def load(arg)
      # 文字列を直接渡された場合は2重配列に変換
      ary = arg.instance_of?(String) ? arg.split("\n").inject([]) {|ary,item| ary << item.split(',')} : arg
      self.new.execute(ary)
    end
    def load_file(path)
      load(FasterCSV.parse(File.read(path)))
    end
  end
end
