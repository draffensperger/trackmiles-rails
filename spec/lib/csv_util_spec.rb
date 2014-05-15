describe CSVUtil do
  before do
    @mock_rows = [['a','b','c'],['1','2','3'],['4','5','6']]
  end

  it 'call hashes from rows with correct rows info' do
    CSVUtil.should_receive(:hashes_from_rows).with(@mock_rows).and_return('mock')
    CSVUtil.load_as_hashes('spec/data/abc_123_456.csv').should eq('mock')
  end

  it 'should create hashes from rows' do
    CSVUtil.hashes_from_rows(@mock_rows)
      .should eq([{a:'1',b:'2',c:'3'},
                  {a:'4',b:'5',c:'6'}])
  end
end