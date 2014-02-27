require_relative 'spec_helper'

describe MailUpdater do
  let(:updater)       { MailUpdater.new :logging => true }
  let(:message_path)  { File.dirname(__FILE__) + '/data/working' }
  let(:test_source)   { TestMailSource.new() }
  let(:test_listener) { TestListener.new() }

  it 'should register listener' do
    @listener1 = double('listener1')
    @listener1.stub(:call => true)

    updater.register @listener1, :event => :some_event

    expect(updater.listeners[:some_event]).to include @listener1
    expect(updater.listeners[:some_event].length).to be 1
  end

  it 'should log processed events' do
    updater.mail_source = test_source
    updater.register test_listener, :event => :new_mail
    updater.process

    expect(updater.history.length).to be 1
    expect(test_listener.has_been_called).to be true
    expect(test_listener.message_count).to be 2
  end

  it 'should process registered listeners' do
    updater.mail_source = test_source
    updater.register test_listener, :event => :new_mail
    updater.process

    expect(test_source.has_been_called).to be true
    expect(test_listener.has_been_called).to be true
  end

  it 'should not emit events if there are no new messages' do
    test_source.no_messages = true
    updater.mail_source = test_source
    updater.register test_listener, :event => :new_mail
    updater.process

    expect(updater.history.length).to be 0
    expect(test_listener.has_been_called).to be false
  end

  it 'captures errors and logs them' do
    system 'rm -f log/test.log'
    expect(File.exist?('log/test.log')).to be false
    updater.logger = Logger.new('log/test.log')

    # sources should be an array - this should trigger an error
    updater.sources = 1
    updater.process

    # test should confirm that test.log has been populated...
    expect(File.exist?('log/test.log')).to be true
  end

  it 'filters out messages that match the pattern specicied' do
    updater.mail_source = test_source
    updater.register test_listener, :event => :new_mail
    updater.ignore_pattern = /message 1/
    updater.process

    expect(updater.history.length).to be 1
    expect(test_listener.has_been_called).to be true
    expect(test_listener.message_count).to be 1
  end

end
