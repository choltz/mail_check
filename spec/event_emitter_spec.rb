require_relative "spec_helper"

describe EventEmitter do
  before(:each) do
    @listener1 = double("listener1")
    @listener2 = double("listener2")
    @emitter   = EventEmitter.new( :logging => true )
  end

  it "should add listeners" do
    @emitter.register @listener1, :event => :buh
    @emitter.register @listener2, :event => :buh

    expect(@emitter.listeners[:buh].length).to be 2
  end

  it "should emit events" do
    @listener1.stub(:call => true)
    @listener2.stub(:call => true)
    @emitter.register @listener1, :event => :buh
    @emitter.register @listener2, :event => :buh
    @emitter.emit(:buh, :x => 1, :y => 2)

    expect(@emitter.history.length).to be 2
  end

  it "should allow the listener to listen to specific events" do
    @listener1.stub(:call => true)
    @listener2.stub(:call => true)

    @emitter.register @listener1, :event => :buh1

    @emitter.emit(:buh1)
    @emitter.emit(:buh2)

    expect(@emitter.history.length).to be 1
  end
end
