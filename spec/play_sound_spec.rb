require_relative "spec_helper"

describe PlaySound do
  it "has a default sound file" do
    action = PlaySound.new
    action.sound_file.should eq "~/scripts/mail/harp.mp3"
  end

  it "plays a sound file when called" do
    action = PlaySound.new

    # Note 1: Normally, I don't advocate using rspepc expect statements to analyize the internal
    # workings of a class, but in this case, it seems the most straight-forward way to determine
    # that mpg123 was called on the shell.
    #
    # Note 2: In a more complicated app, I would likely create a class that wrapped shell calls and
    # stub that in unit tests.
    Kernel.should_receive(:system).with("mpg123 --quiet ~/scripts/mail/harp.mp3")
    action.call
  end

  it "can override the default sound file" do
    action = PlaySound.new
    action.sound_file = "~/override.mp3"

    Kernel.should_receive(:system).with("mpg123 --quiet ~/override.mp3")
    action.call
  end
end
