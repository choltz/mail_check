require "simplecov"
SimpleCov.start
require_relative "../sys/load_app.rb"

LoadApp.new(env: "spec")

RSpec.configure do |config|
  config.color_enabled = true
  config.mock_with :rspec
end
