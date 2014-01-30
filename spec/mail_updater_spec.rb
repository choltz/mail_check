require_relative "spec_helper"

describe MailUpdater do
  let(:updater)       { MailUpdater.new :logging => true }
  let(:message_path)  { File.dirname(__FILE__) + "/data/working" }
  let(:test_source)   { TestMailSource.new() }
  let(:test_listener) { TestListener.new() }

  it "should register listener" do
    @listener1 = mock("listener1")
    @listener1.stub(:call => true)

    updater.register @listener1, :event => :some_event

    updater.listeners[:some_event].should include(@listener1)
    updater.listeners[:some_event].length.should eq(1)
  end

  it "should add sources" do
    updater.add_mail_source test_source
    updater.sources.length.should eq(1)
  end

  it "should log processed events" do
    updater.add_mail_source test_source
    updater.register test_listener, :event => :new_mail
    updater.process

    updater.history.length.should eq(1)
    test_listener.has_been_called.should eq(true)
    test_listener.message_count.should eq 2
  end

  it "should process registered listeners" do
    updater.add_mail_source test_source
    updater.register test_listener, :event => :new_mail
    updater.process

    test_source.has_been_called.should eq(true)
    test_listener.has_been_called.should eq(true)
  end

  it "should not emit events if there are no new messages" do
    test_source.no_messages = true
    updater.add_mail_source test_source
    updater.register test_listener, :event => :new_mail
    updater.process

    updater.history.length.should eq(0)
    test_listener.has_been_called.should eq(false)
  end

  it "captures errors and logs them" do
    system "rm -f log/test.log"
    File.exist?("log/test.log").should eq false
    updater.logger = Logger.new("log/test.log")

    # sources should be an array - this should trigger an error
    updater.sources = 1
    updater.process

    # test should confirm that test.log has been populated...
    File.exist?("log/test.log").should eq true
  end

  it "filters out messages that match the pattern specicied" do
    updater.add_mail_source test_source
    updater.register test_listener, :event => :new_mail
    updater.ignore_pattern = /message 1/
    updater.process

    updater.history.length.should eq(1)
    test_listener.has_been_called.should eq(true)
    test_listener.message_count.should eq 1
  end

end
