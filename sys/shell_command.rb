class ShellCommand

  # Public: Kill off the mu process; if we don't, the mu indexer won't be able to
  # get a lock
  def kill_mu
    `pgrep -f '/mu server'`.split("\n").each{ |p| `kill -9 #{p}` }
    `sleep 2`
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
