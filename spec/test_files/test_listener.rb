class TestListener
  attr_accessor :has_been_called
  attr_accessor :message_count

  def initialize
    @has_been_called = false
    @message_count   = 0
  end

  def call(options={})
    @has_been_called = true
    @message_count   = options[:messages].length
  end

end
