require_relative "spec_helper"

describe EventEmitter do
  before(:each) do
    @listener1 = mock("listener1")
    @listener2 = mock("listener2")
    @emitter   = EventEmitter.new( :logging => true )
  end

  it "should add listeners" do
    @emitter.register @listener1, :event => :buh
    @emitter.register @listener2, :event => :buh

    @emitter.listeners[:buh].length.should eq(2)
  end

  it "should emit events" do
    @listener1.stub(:call => true)
    @listener2.stub(:call => true)
    @emitter.register @listener1, :event => :buh
    @emitter.register @listener2, :event => :buh
    @emitter.emit(:buh, :x => 1, :y => 2)

    @emitter.history.length.should eq(2)
  end

  it "should allow the listener to listen to specific events" do
    @listener1.stub(:call => true)
    @listener2.stub(:call => true)

    @emitter.register @listener1, :event => :buh1

    @emitter.emit(:buh1)
    @emitter.emit(:buh2)

    @emitter.history.length.should eq(1)
  end
end
