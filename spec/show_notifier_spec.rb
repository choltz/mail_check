require_relative "spec_helper"

describe ShowNotifier do
  let(:action) { ShowNotifier.new }

  it "displays a popup notification containing message data" do
    messages = ["buh1", "buh2"]

    expect(action.shell).to receive(:show_notification).with("New Mail", "You have #{messages.length} unread messages.\nDebug: #{messages}")
    action.call :messages => messages
  end

  it "doesn't display a notiication if there are no messages" do
    expect(action.shell).to_not receive(:show_notification)
    action.call :messages => []
  end
end
