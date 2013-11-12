require_relative 'sys/mail_updater'
require_relative 'actions/offlineimap'
require_relative 'actions/mu_index'
require_relative 'actions/play_sound'
require_relative 'actions/show_notifier'
require_relative 'actions/message_logger'

begin
  # Create a mail updated and add a mail source
  updater = MailUpdater.new
  updater.add_mail_source  Offlineimap.new

  # Register listeners - these actions will take effect when new mail arrives
  updater.register MuIndex.new,       :event => :new_mail
  updater.register PlaySound.new,     :event => :new_mail
  updater.register ShowNotifier.new,  :event => :new_mail
  updater.register MessageLogger.new, :event => :new_mail

  # Check for new mail
  updater.process
rescue Exception => e
  # As this is meant to run in the background, wrap this all in an exception check
  puts e.message
  puts e.backtrace.join("\n")
end
