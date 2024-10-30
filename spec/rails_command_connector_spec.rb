RSpec.describe Foobara::RailsCommandConnector do
  start_rails

  context "running commands", type: :request do
    it "can hit a URL" do
      get "/test_suite/run/CalculateExponent", params: { exponent: 3, base: 2 }
      expect(response.status).to eq(200)
      expect(response.body).to eq("8")
    end
  end
end
