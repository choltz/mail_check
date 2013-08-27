# Public: Calls offlineimap to sync up mail box
class Offlineimap
  def call
    puts '*** starting offline imap synchronization'
    old_messages = messages

    # Kill existing offlineimap process and start a new one
    puts `pgrep -f 'offlineimap'`.split("\n").each{ |p| `kill -9 #{p}` }
    system 'offlineimap -u quiet' # `offlineimap -u quiet`
    new_messages = messages
    puts '*** imap synchronization complete'

    new_messages - old_messages
  end

  # Internal: Retrieve message file names
  def messages
    Dir["#{ENV["HOME"]}/Maildir/*/*/*"]
  end

end
