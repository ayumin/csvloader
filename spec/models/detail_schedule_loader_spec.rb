# -*- encoding: utf-8 -*-
require 'spec_helper'

describe DetailScheduleLoader do
  describe 'クラスメソッドが呼ばれたとき' do
    context 'new' do
      before do
        @loader = DetailScheduleLoader.new
      end
      subject { @loader.class }
      it { should == DetailScheduleLoader }
    end
    context 'load' do
      context 'normalizeをオーバライドしないとき' do
        before do
          @result = DetailScheduleLoader.load([["a","b","c"],["1","2","3"],["","",""],["4","5","6"]])
        end
        subject { @result }
        it { should == { "DetailSchedule" => [{:a => "1",:b => "2", :c => "3"},{:a => "4",:b => "5",:c => "6"}]} }
      end
      context 'normalizeをオーバーライドしたとき' do
        before do
          class DetailScheduleLoader
            def normalize(data)
              { "Hoge" => data }
            end
          end
          @result = DetailScheduleLoader.load([["a","b","c"],["1","2","3"],["","",""],["4","5","6"]])
        end
        subject { @result }
        it { should == { "Hoge" => [{:a => "1",:b => "2", :c => "3"},{:a => "4",:b => "5",:c => "6"}]} }
      end
    end
    context 'load_file' do
    end
  end
end
