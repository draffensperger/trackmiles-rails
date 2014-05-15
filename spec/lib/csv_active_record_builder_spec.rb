describe CSVActiveRecordBuilder do
  class CSV_ABC < ActiveRecord::Base
  end

  before do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table :csv_abcs do |t|
      t.integer :a
      t.integer :b
      t.integer :c
    end

    @mock_rows = [['a','b','c'],['1','2','3'],['4','5','6']]
  end

  after do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table :csv_abcs
  end

  it 'call rows with correct rows info' do
    CSVActiveRecordBuilder.should_receive(:build_from_rows)
      .with('CSV_ABC', @mock_rows).and_return('mock')
    CSVActiveRecordBuilder.build('CSV_ABC', 'spec/data/abc_123_456.csv')
      .should eq('mock')
  end

  it 'should create object from rows' do
    abcs = CSVActiveRecordBuilder.build_from_rows('CSV_ABC', @mock_rows)
    abcs.length.should eq(2)
    abcs[0].attributes.should eq({id:nil,a:1,b:2,c:3}.stringify_keys)
    abcs[1].attributes.should eq({id:nil,a:4,b:5,c:6}.stringify_keys)
  end
end