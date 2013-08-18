class MuIndex
  def call(options={})
    options = { :messages => [] }.update(options)
    puts "Updating mu index"

    kill_mu
    puts `/usr/local/bin/mu index --maildir=/home/choltz/Maildir`
    # kill the mu process again, otherwise the lock can prevent mu4e
    # from showing mail
    kill_mu

    puts "index update complete"
  end

  private

  # Internal: Kill off the mu process. We won't be able to run the indexer
  # if mu is already running
  def kill_mu
    `pgrep -f '/mu server'`.split("\n").each{ |p| `kill -9 #{p}` }
    `sleep 2`
  end
end
