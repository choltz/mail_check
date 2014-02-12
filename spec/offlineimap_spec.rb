require_relative 'spec_helper'

describe Offlineimap do
  let(:offlineimap) { Offlineimap.new }

  it 'kills and restarts the offlineimap shell process' do
    expect(offlineimap.shell).to receive(:kill_offlineimap)
    expect(offlineimap.shell).to receive(:offlineimap_messages)

    offlineimap.retrieve
  end

  it 'returns all new messages as an array of message file paths' do
    offlineimap.shell.stub(:offlineimap_messages)
    offlineimap.shell.stub(:kill_offlineimap)
    offlineimap.stub(:messages) { ['message 2'] }

    offlineimap.old_messages = ['message 1']
    offlineimap.retrieve

    expect(offlineimap.new_messages).to eq ['message 2']
  end

  it 'returns an empty array if there are no new messages' do
    offlineimap.shell.stub(:offlineimap_messages)
    offlineimap.shell.stub(:kill_offlineimap)

    offlineimap.new_messages = []
    offlineimap.retrieve

    expect(offlineimap.new_messages).to eq []
  end
end
