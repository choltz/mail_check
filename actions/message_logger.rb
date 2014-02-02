require 'logger'

# Public: Simple logger class to dump message information to log/message.log
class MessageLogger
  # Public: invoke the message logger
  #   options: hash of key value pairs to write to the log file
  def call(options={})
    logger = Logger.new("log/message.log")
    logger.debug(options[:messages])
  end
end
