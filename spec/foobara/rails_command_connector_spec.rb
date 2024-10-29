require_relative "../fixtures/rails-test-app/config/environment"
require "rspec/rails"

RSpec.describe Foobara::RailsCommandConnector do
  it "has a version number" do
    expect(Foobara::RailsCommandConnector::VERSION).to_not be_nil
  end
end
