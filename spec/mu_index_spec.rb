require_relative 'spec_helper'

describe MuIndex do
  it 'Updates the mu index' do
    action       = MuIndex.new
    expect(action.shell).to receive(:update_mu_index)
    action.call
  end
end
