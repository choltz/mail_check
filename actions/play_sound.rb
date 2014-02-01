# Public: Play a sound file
class PlaySound
  attr_accessor :sound_file

  def initialize
    @sound_file = "~/scripts/mail/harp.mp3"
  end

  # Public: Spawn mpg123 in a shell to play the sound
  def call(options={})
    # Note: I use Kernel here instead of just 'system' or backticks, because it makes it easier to
    # check expectations in rspec. See spec/play_sound_spec.rb for more notes on this.
    Kernel.system "mpg123 --quiet #{sound_file}"
  end
end
