# Public: Play a sound file
class PlaySound
  attr_accessor :shell
  attr_accessor :sound_file

  def initialize
    @sound_file = '~/scripts/mail/harp.mp3'
    @shell      = ShellCommand.new
  end

  # Public: Play a sound file
  def call(messages: [])
    @shell.play_sound(@sound_file)
  end
end
