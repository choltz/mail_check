require_relative 'event_emitter'

# Public: Register multiple sources for email and check each of them
# for new mail. Send messages to registered services if there are
# new messages.
#
# Examples
#   updater = MailUpdater.new(:logging => true)
#   updater.add_mail_source OfflineImapSource.new
#   updater.process
class MailUpdater < EventEmitter
  # Note: it would be better to compose with an event emitter class than
  # to inherit from it...

  attr_accessor :sources
  attr_accessor :ignore_pattern

  # Public: constructor
  def initialize(options = {})
    @sources = []
    super(options)
  end

  # Public: Add a mail source to process
  def add_mail_source(source)
    @sources << source
  end

  # Public:
  def process
    # Call each source and collect the messages
    messages = @sources.inject([]){ |a, e| e.call }.flatten

    # Reduce the new message list by filtering out by a regex pattern
    messages = messages.select{ |m| m !~ @ignore_pattern }

    after_check_events messages
  rescue Exception => e
    puts e.message
    puts ''
    puts e.backtrace
  end

  private

  # Internal: Raise events to subscribers
  def after_check_events(messages)
    emit(:after_check, :messages => messages.flatten)
    emit(:new_mail,    :messages => messages.flatten) if !messages.empty?
  end

end
