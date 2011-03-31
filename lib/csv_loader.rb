# -*- encoding: utf-8 -*-
require 'fastercsv'
class CSVLoader
  include Loadable
  class << self
    def load(str)
      self.new.import(str)
    end
    def load_file(path)
      load(FasterCSV.read(path))
    end
  end
end
