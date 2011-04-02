# -*- encoding: utf-8 -*-
require 'spec_helper'

describe DetailScheduleLoader do
  describe 'クラスメソッドが呼ばれたとき' do
    describe 'new' do
      before do
        @loader = DetailScheduleLoader.new
      end
      subject { @loader.class }
      it { should == DetailScheduleLoader }
    end
    describe 'load' do
      context 'normalizeをオーバライドしないとき' do
        before do
          test_data =[]
          test_data << ["a","b","c"]
          test_data << ["1","2","3"]
          test_data << ["","",""]
          test_data << ["4","5","6"]

          @result = DetailScheduleLoader.load(test_data)
        end
        subject { @result }
        it { subject["DetailSchedule"].should == [{:a => "1",:b => "2", :c => "3"},{:a => "4",:b => "5",:c => "6"}] }
      end
      context 'normalizeをオーバーライドしたとき' do
        before do
          class DetailScheduleLoader
            def normalize
              { "Hoge" => @row_data }
            end
          end
          @result = DetailScheduleLoader.load([["a","b","c"],["1","2","3"],["","",""],["4","5","6"]])
        end
        subject { @result }
        it { subject["Hoge"].should == [{:a => "1",:b => "2", :c => "3"},{:a => "4",:b => "5",:c => "6"}] }
      end
      context 'テーブル分割をしたとき' do
        before do
          class DetailScheduleLoader
            def normalize
              {
                "Hoge" => @row_data.map {|d| d.slice(:a,:b)},
                "Fuga" => @row_data.map {|d| d.slice(:a,:c)}
              }
            end
          end
          @result = DetailScheduleLoader.load([["a","b","c"],["1","2","3"],["","",""],["4","5","6"]])
        end
        subject { @result }
        it { subject["Hoge"].should == [{:a => "1",:b => "2"}, {:a => "4", :b => "5"}]}
        it { subject["Fuga"].should == [{:a => "1",:c => "3"}, {:a => "4", :c => "6"}]}        
      end
    end
    describe 'load_file' do
    end
  end
end
