RSpec.describe Foobara::RailsCommandConnector do
  start_rails

  context "when hitting a url", type: :request do
    it "can hit a URL" do
      get "/run/CalculateExponent", params: { exponent: 2, base: 3 }
      expect(response).to be_successful
    end
  end
end
