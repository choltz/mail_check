require_relative 'event_emitter'

# Public: Register multiple sources for email and check each of them
# for new mail. Send messages to registered services if there are
# new messages.
#
# Examples
#   updater = MailUpdater.new
#   updater.add_mail_source OfflineImapSource.new
#   updater.process
class MailUpdater < EventEmitter
  # Note: it would be better to compose with an event emitter class than
  # to inherit from it...

  attr_accessor :ignore_pattern
  attr_accessor :logger
  attr_accessor :mail_source
  attr_accessor :sources

  # Public: constructor
  def initialize(**options)
    @sources = []
    @logger  = NoLogger.new
    super(**options)
  end

  # Public: process mail sources and emit events to the listeners
  #   Events
  #     after_check:   runs after mail check is complete
  #     before_filter: runs after the mail check, but before messages are
  #                    filtered out by the @ignore_pattern instance variable
  #     new_mail:      runs after mail check is complete but only if there are
  #                    new messages.
  def process
    mail_source.fetch
    messages = mail_source.new_messages

    emit(:before_filter, :messages => messages)

    # filter out messages we don't want to process
    messages.select! { |message| message !~ @ignore_pattern }

    after_check_events messages
  rescue Exception => exception
    @logger.error exception.message
    @logger.error exception.backtrace.join("\n")
  end

  private

  # Internal: Raise events to subscribers
  def after_check_events(messages)
    emit(:after_check, :messages => messages)
    emit(:new_mail,    :messages => messages) if !messages.empty?
  end
end
