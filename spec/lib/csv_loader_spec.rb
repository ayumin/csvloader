# -*- encoding: utf-8 -*-
require 'spec_helper'

describe CSVLoader do
  describe 'クラスメソッドが呼ばれたとき' do
    context 'new' do
      before do
        @loader = CSVLoader.new
      end
      subject { @loader.class }
      it { should == CSVLoader }
    end
    context 'load' do
      before do
        @result = CSVLoader.load([["a","b","c"],["1","2","3"],["","",""],["4","5","6"]])
      end
      subject { @result }
      it { should == { "CSV" => [{:a => "1",:b => "2", :c => "3"},{:a => "4",:b => "5",:c => "6"}]} }
    end
    context 'load_file' do
    end
  end
  
end
