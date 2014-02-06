require 'logger'

# Public: Simple logger class to dump message information to log/message.log
class MessageLogger
  attr_accessor :logger

  def initialize
    @logger = Logger.new("log/message.log")
  end

  # Public: invoke the message logger
  #   options: hash of key value pairs to write to the log file
  def call(messages: [])
    @logger.debug(messages)
  end
end
