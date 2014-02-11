# Public: Display the message data in a popup notificaton
class ShowNotifier
  attr_accessor :shell

  def initialize
    @shell = ShellCommand.new
  end

  # Public: Invoke this action - display message data in a notification window
  #  options:
  #    messages - array of message data.
  def call(messages: [])
    if messages.length > 0
      text = ""

      messages.each do |message_path|
        message = Mail.read(message_path)
        text << "#{message.from.first}\n#{message.subject}\n\n"
      end

      @shell.show_notification "New Mail\n", text
    end
  end

end
