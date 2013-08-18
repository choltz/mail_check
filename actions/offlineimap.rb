class Offlineimap
  def call
    old_messages = messages
    puts "*** starting offline imap synchronization"
    system "offlineimap -u quiet" # `offlineimap -u quiet`
    new_messages = messages
    puts "*** imap synchronization complete"

    return new_messages - old_messages
  end

  def messages()
    Dir["#{ENV["HOME"]}/Maildir/*/*/*"]
  end

end
