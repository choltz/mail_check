class TestListener
  attr_accessor :has_been_called

  def initialize
    @has_been_called = false
  end

  def call(options={})
    @has_been_called = true
  end

end
