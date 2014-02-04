require_relative "spec_helper"

describe Offlineimap do
  let(:offlineimap) { Offlineimap.new }

  it "kills and restarts the offlineimap shell process" do
    expect(offlineimap.shell).to receive(:kill_offlineimap)
    expect(offlineimap.shell).to receive(:get_offlineimap_messages)

    offlineimap.retrieve
  end

  it "returns all new messages as an array of message file paths" do
#    expect(offlineimap.shell).to receive(:kill_offlineimap)
#
#    offlineimap.shell.stub(:get_offlineimap_messages) { "" }
  end

  it "returns an empty array if there are no new messages" do

  end
end
