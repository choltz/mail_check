class TestMailSource
  attr_accessor :has_been_called,
                :no_messages,
                :new_messages

  def initialize
    @has_been_called = false
  end

  def retrieve
    @has_been_called = true

    if @no_messages == true
      @new_messages = []
    else
      @new_messages = ["message 1", "message 2"]
    end
  end
end
