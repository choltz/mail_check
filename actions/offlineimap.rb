# Public: Calls offlineimap to sync up mail box
class Offlineimap
  attr_accessor :shell
  attr_accessor :new_messages
  attr_accessor :old_messages

  def initialize
    @shell        = ShellCommand.new
    @old_messages = messages
  end

  # Public: Invoke offlineimap and return new messages
  def fetch
    @shell.kill_offlineimap
    @shell.offlineimap_messages
    @new_messages = messages - @old_messages
  end

  private

  # Internal: Retrieve message file names
  def messages
    Dir["#{@shell.home_path}/Maildir/*/*/*"]
  end
end
