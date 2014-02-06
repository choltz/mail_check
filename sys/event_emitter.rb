# Public: simple event emitter class. Classes that inherit from this can
# register listeners and inform those listeners when events are emitted
class EventEmitter
  attr_accessor :listeners
  attr_accessor :history

  # Public: constructor
  def initialize(logging: true)
    @logging       = logging
    @listeners     = {}
    @history       = []
  end

  # raise an event to all listeners
  def emit(event, **options)
    return if !@listeners.has_key?(event)

    @listeners[event].each do |listener|
      listener.call(**options)
      @history << [event, **options] if @logging == true
    end
  end

  # Pubic: regiester an event listener
  #
  # listener - object that will listen for emitted events
  # options:
  #   event  - the event that the listener will listen for
  #   method - the method to call when the event is raised
  def register(listener, event: :none, method: :call)
    (@listeners[event] ||= []) << listener
  end
end
