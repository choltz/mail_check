require_relative "sys/load_app"
require          "debugger"

begin
  LoadApp.new(env: "dev")

  # Create a mail updated and add a mail source
  updater = MailUpdater.new
  updater.logger = Logger.new("log/message.log")
  updater.add_mail_source  Offlineimap.new
  updater.ignore_pattern = /(all mail|important|trash|sent|drafts|arcana)/i

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
