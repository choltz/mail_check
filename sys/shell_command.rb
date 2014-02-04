# Public: Wrapper class to encapsulate shell operations. This way we can easily
# stub out shell calls and set expectations in unit tests.
class ShellCommand

  # Public: Retrieve messages with offlineimap
  def get_offlineimap_messages
    Kernel.system 'offlineimap -u quiet'
  end

  # Public: Kill off the mu process; if we don't, the mu indexer won't be able to
  # get a lock
  def kill_mu
    processes = `pgrep -f '/mu server'`.split("\n")
    processes.each do |p|
      Kernel.system "kill -9 #{p}"
    end
    Kernel.system "sleep 2"
  end

  # Public: Kill off the offlineimap process
  def kill_offlineimap
   `pgrep -f 'offlineimap'`.split("\n").each{ |p| `kill -9 #{p}` }
  end

  # Public: Dispaly a popup notification with the text specified
  def show_notification(title, text)
    prefix = "DISPLAY=:0.0 XAUTHORITY=~/.Xauthority"
    Kernel.system "#{prefix} notify-send '#{title}' '#{text}' -t 4000"
  end

  # Public: Update the mu index
  def update_mu_index
    # Note: The mu index operation may be running - just kill it and start over
    kill_mu
    Kernel.system "mu index --maildir=/home/choltz/Maildir"
    kill_mu
  end

end
