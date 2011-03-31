# -*- encoding: utf-8 -*-
require 'fastercsv'
class CSVLoader
  include Loadable
  class << self
    def load(ary)
      self.new.execute(ary)
    end
    def load_file(path)
      load(FasterCSV.read(path))
    end
  end
end
