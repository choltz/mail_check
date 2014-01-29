require 'logger'

# Public: Simple logger class to dump message information to log/message.log
class MessageLogger
  # Public: invoke the message logger
  #   options: hash of key value pairs to write to the log file
  #
  #   Note:
  #   The plan is to enhance this class to parse the message and log more thant just
  #   the file and path.
  def call(options={})
    logger = Logger.new("log/message.log")
    logger.debug(options[:messages])
  end
end
