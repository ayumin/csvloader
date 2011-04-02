# -*- encoding: utf-8 -*-
require 'spec_helper'

describe CSVLoader do
  describe 'クラスメソッド' do
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
          test_data =[]
          test_data << ["a","b","c"]
          test_data << ["1","2","3"]
          test_data << ["","",""]
          test_data << ["4","5","6"]
          @result = CSVLoader.load(test_data)
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
  describe 'インスタンスメソッド' do
    describe 'convert' do
      before do
        @loader = CSVLoader.new
      end
      context '項目名のsuffixが_dateの場合' do
        subject { @loader.__send__(:convert, "5/21/2010", :some_date)}
        it { should eq Date.new(2010,5,21) }
      end
      context '項目名のsuffixが_atの場合' do
        subject { @loader.__send__(:convert, "5/21/2010 10:45:30", :some_at)}
        it {should eq DateTime.new(2010,5,21,10,45,30)}
      end
      context '項目名のsuffixが_fの場合' do
        it { @loader.__send__(:convert, "12", :some_f).should eq 12.0 }
        it { @loader.__send__(:convert, "12.3", :some_f).should eq 12.3 }
      end
      context '項目名のsuffixが_mdの場合' do
        it { @loader.__send__(:convert, "12", :some_md).should eq 12.0 }
        it { @loader.__send__(:convert, "12.3", :some_md).should eq 12.3 }
      end
      context '項目名のsuffixが_rateの場合' do
        it { @loader.__send__(:convert, "12", :some_rate).should eq 12.0 }
        it { @loader.__send__(:convert, "12.3", :some_rate).should eq 12.3 }
      end
      context '項目名のsuffixが_iの場合' do
        it { @loader.__send__(:convert, "12", :some_i).should eq 12 }
        it { @loader.__send__(:convert, "12.3", :some_i).should eq 12 }
      end
      context '項目名のsuffixが_daysの場合' do
        it { @loader.__send__(:convert, "12", :some_days).should eq 12 }
        it { @loader.__send__(:convert, "12.3", :some_days).should eq 12 }
      end
      context '項目名のsuffixが_idの場合' do
        it { @loader.__send__(:convert, "12", :some_id).should eq 12 }
        it { @loader.__send__(:convert, "12.3", :some_id).should eq 12 }
      end
      context '項目名のsuffixが_noの場合' do
        it { @loader.__send__(:convert, "12", :some_no).should eq 12 }
        it { @loader.__send__(:convert, "12.3", :some_no).should eq 12 }
      end
      context '項目名のsuffixが_numの場合' do
        it { @loader.__send__(:convert, "12", :some_num).should eq 12 }
        it { @loader.__send__(:convert, "12.3", :some_num).should eq 12 }
      end
    end
  end
end
