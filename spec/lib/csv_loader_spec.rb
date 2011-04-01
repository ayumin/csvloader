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
    describe 'load' do
      context '配列が渡されたとき' do
        before do
          @result = CSVLoader.load([["a","b","c"],["1","2","3"],["","",""],["4","5","6"]])
        end
        subject { @result }
        it { subject["CSV"].should == [{:a => "1",:b => "2", :c => "3"},{:a => "4", :b => "5", :c => "6"}] }
      end
      context '文字列が渡されたとき' do
        before do
          @result = CSVLoader.load(<<-_CSV_)
a,b,c
1,2,3
4,5,6
_CSV_
        end
        subject { @result }
        it { subject["CSV"].should == [{:a => "1",:b => "2", :c => "3"},{:a => "4", :b => "5", :c => "6"}] }
      end
    end

    context 'load_file' do
    end
  end
  
end
