# Based on https://github.com/CruGlobal/mpdx/blob/master/spec/lib/async_spec.rb
require File.expand_path('../../spec_helper', __FILE__)

class Foo
  include Async

  def feed(person) end
end

describe 'Async' do
  it 'should perform a method with an id' do
    foo = double('foo')
    Foo.should_receive(:find).with(5).and_return(foo)
    foo.should_receive(:feed).with('Cat')
    Foo.new.perform(5, :feed, 'Cat')
  end

  it 'should perform a method without an id' do
    foo = Foo.new
    foo.should_receive(:feed).with('Cat')
    foo.perform(nil, :feed, 'Cat')
  end
end