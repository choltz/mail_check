# Public: Display the message data in a popup notificaton
class ShowNotifier
  attr_accessor :shell

  def initialize
    @shell = ShellCommand.new
  end

  # Public: Invoke this action - display message data in a notification window
  #  options:
  #    messages - array of message data.
  def call(options={})
    options = { :messages => [] }.update(options)

    if options[:messages].length > 0
      @shell.show_notification "New Mail", "You have #{options[:messages].length} unread messages.\nDebug: #{options[:messages]}"
    end
  end
end
