require File.expand_path('../../spec_helper', __FILE__)

describe ThreadSafeSet do
  before do
    @set = ThreadSafeSet.new
  end

  it 'should allow add member and delete' do
    h1 = {a: 2, b: [1,2]}
    h1_same = {a: 2, b: [1,2]}
    h2 = {a: 3, b: [1,4]}
    expect(@set.member?(h1)).to be_falsey
    @set.add h1
    expect(@set.member?(h1)).to be_truthy
    expect(@set.member?(h1_same)).to be_truthy

    @set.delete h1
    expect(@set.member? h1).to be_falsey

    expect(@set.member? h2).to be_falsey
    @set.add h2
    @set.add h2
    expect(@set.member? h2).to be_truthy
  end
end