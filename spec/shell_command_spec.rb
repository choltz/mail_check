require_relative "spec_helper"

# NOTE: Because this class houses direct external calls, there isn't really a
# clean way to test it without inspecting internals of the method behavior.
# As such, most tests in this file call a ShellCommand method and check the
# text of the command sent to the shell.
describe ShellCommand do
  let(:shell) { ShellCommand.new }

  it "calls offlineimap to retrieve messages" do
    shell.should_receive(:'`').with("offlineimap -u quiet")
    shell.get_offlineimap_messages
  end

  it "returns the current users's home directory" do
    expect(shell.home_path).to eq ENV["HOME"]
  end

  it "kills the mu process" do
    shell.should_receive(:'`').with("killall -9 mu")
    shell.kill_mu
  end

  it "kills the offlineimap process" do
    shell.should_receive(:'`').with("killall -9 offlineimap")
    shell.kill_offlineimap
  end

  it "displays a popup notification" do
    title = "this is the title"
    text  = "this is the text"

    shell.should_receive(:'`').with("DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send '#{title}' '#{text}' -t 4000")
    shell.show_notification title, text
  end

  it "updates the mu index" do
    shell.stub(:kill_mu) { nil }
    shell.should_receive(:'`').with("mu index --maildir=#{shell.home_path}/Maildir")
    shell.update_mu_index
  end

end
