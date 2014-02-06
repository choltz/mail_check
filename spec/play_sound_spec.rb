require_relative "spec_helper"

describe PlaySound do
  it "has a default sound file" do
    action = PlaySound.new
    expect(action.sound_file).to eq "~/scripts/mail/harp.mp3"
  end

  it "plays a sound file when called" do
    action = PlaySound.new
    expect(action.shell).to receive(:play_sound)
    action.call
  end

  it "can override the default sound file" do
    action = PlaySound.new
    action.sound_file = "~/override.mp3"

    expect(action.shell).to receive(:play_sound).with("~/override.mp3")
    action.call
  end
end
