class TestMailSource
  attr_accessor :has_been_called, :no_messages

  def initialize
    @has_been_called = false
  end

  def call
    @has_been_called = true
    @no_messages == true ? [] : ["message 1", "message 2"]
  end
end
