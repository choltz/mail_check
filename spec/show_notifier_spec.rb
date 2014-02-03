require_relative "spec_helper"

describe ShowNotifier do
  it "displays a popup notification containing message data" do
    action   = ShowNotifier.new
    messages = ["buh1", "buh2"]

    expect(Kernel).to receive(:system).with("#{action.prefix} notify-send 'New Mail' 'You have #{messages.length} unread messages.\nDebug: #{messages}' -t 4000")
    action.call :messages => messages
  end
end
