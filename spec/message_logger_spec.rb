require_relative "spec_helper"

describe MessageLogger do
  let(:logger) { MessageLogger.new }
  it "logs message data to the log file specified" do
    system "rm -f log/test.log"

    expect(File.exist?("log/test.log")).to be false
    logger.logger = Logger.new("log/test.log")
    logger.call :messages => ["message 1", "message 2"]

    # test should confirm that test.log has been populated...
    expect(File.exist?("log/test.log")).to be true
  end

  # note: it would be good to have a test that verifies the contents of the
  # log file; not just a test that verifies the log file was created
end
