require 'logger'
class MessageLogger
  def call(options={})
    logger = Logger.new("log/message.log")
    logger.debug(options[:messages])
  end
end
