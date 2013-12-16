# Public: Calls offlineimap to sync up mail box
class Mbsync
  def call
    puts '*** starting mbsync'
    old_messages = messages

    # Kill existing offlineimap process and start a new one
    # puts `pgrep -f 'offlineimap'`.split("\n").each{ |p| `kill -9 #{p}` }
    # system 'offlineimap -u quiet' # `offlineimap -u quiet`
    system 'mbsync gmail'
    new_messages = messages
    puts '*** imap mbsync complete'

    new_messages - old_messages
  end

  # Internal: Retrieve message file names
  def messages
    Dir["#{ENV["HOME"]}/Maildir/*/*/*"]
  end

end
