# Public: Calls offlineimap to sync up mail box
class Offlineimap
  attr_accessor :shell

  def initialize
    @shell = ShellCommand.new
  end

  # Public: Invoke offlineimap and return new messages
  #
  # Returns: an array of new message file paths
  def call
    old_messages = messages

    @shell.kill_offlineimap
    @shell.get_offlineimap_messages

    messages - old_messages
  end

  private

  def home_path
    ENV["HOME"]
  end

  # Internal: Retrieve message file names
  def messages
    Dir["{home_path}/Maildir/*/*/*"]
  end

end
