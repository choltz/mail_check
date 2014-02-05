# Public: Wrapper class to encapsulate shell operations. This way we can easily
# stub out shell calls and set expectations in unit tests.
class ShellCommand

  # Public: Retrieve messages with offlineimap
  def get_offlineimap_messages
    `offlineimap -u quiet`
  end

  # Return the home path of the current user
  def home_path
    # OK, technically this isn't a shell command, though it could have been coded
    # as `echo $HOME`
    ENV["HOME"]
  end

  # Public: Kill off the mu process; if we don't, the mu indexer won't be able to
  # get a lock
  def kill_mu
    `killall -9 mu`
  end

  # Public: Kill off the offlineimap process
  def kill_offlineimap
    `killall -9 offlineimap`
  end

  # Public: Play a sound file
  def play_sound(file)
    `mpg123 --quiet #{file}`
  end

  # Public: Dispaly a popup notification with the text specified
  def show_notification(title, text)
    prefix = "DISPLAY=:0.0 XAUTHORITY=~/.Xauthority"
    `#{prefix} notify-send '#{title}' '#{text}' -t 4000`
  end

  # Public: Update the mu index
  def update_mu_index
    # Note: The mu index operation may be running - just kill it and start over
    kill_mu
    `mu index --maildir=#{home_path}/Maildir`
    kill_mu
  end

end
