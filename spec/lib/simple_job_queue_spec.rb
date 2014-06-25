require File.expand_path('../../spec_helper', __FILE__)

describe SimpleJobQueue do
  before do
    @q = SimpleJobQueue.new 2
  end

  it 'should queue and run jobs' do

  end
end