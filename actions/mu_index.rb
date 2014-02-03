# Public: Update the mu index.
# This class is a wrapper for the ShellCommand.update_mu_index call. It conforms to the expected
# interface of a mail action, so we can register it with the MailUpdater class
class MuIndex
  attr_accessor :shell

  def initialize
    @shell = ShellCommand.new
  end

  def call(options={})
    puts "Updateing MU Index"
    @shell.update_mu_index
  end
end
