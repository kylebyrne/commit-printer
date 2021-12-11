require 'rack/test'
require_relative "../app"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Rack::Test::Methods

  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random

  def app
    App.freeze
  end

  Kernel.srand config.seed
end
