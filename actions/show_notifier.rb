# Public: Display the message data in a popup notificaton
class ShowNotifier
  attr_accessor :prefix

  def initialize
    @prefix = "DISPLAY=:0.0 XAUTHORITY=~/.Xauthority"
  end

  # Public: Invoke this action - display message data in a notification window
  #  options:
  #    messages - array of message data.
  def call(options={})
    options = { :messages => [] }.update(options)
    Kernel.system "#{@prefix} notify-send 'New Mail' 'You have #{options[:messages].length} unread messages.\nDebug: #{options[:messages]}' -t 4000"
  end
end
