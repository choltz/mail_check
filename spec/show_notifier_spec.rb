require_relative 'spec_helper'

describe ShowNotifier do
  let(:action) { ShowNotifier.new }

  it 'displays a popup notification containing message data' do
    messages = ['/data/message1.mail', 'data/message2.mail'].map do |message|
      File.expand_path(File.join(File.dirname(__FILE__), message))
    end

    text = "Test.User@buh.buh\nTest message 1\n\nTest.User@buh.buh\nTest message 1\n\n"
    expect(action.shell).to receive(:show_notification).with("New Mail\n", text)

    action.call :messages => messages
  end

  it 'doesn\'t display a notiication if there are no messages' do
    expect(action.shell).to_not receive(:show_notification)
    action.call :messages => []
  end
end
