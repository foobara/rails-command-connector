ENV["RAILS_ENV"] = "test"

require_relative "../fixtures/rails-test-app/config/environment"
require "rspec/rails"

RSpec.describe Foobara::RailsCommandConnector do
  it "has a version number" do
    expect(Foobara::RailsCommandConnector::VERSION).to_not be_nil
  end

  context "when hitting a url", type: :request do
    it "can hit a URL" do
      get "/up"
      expect(response).to be_successful
    end
  end
end
