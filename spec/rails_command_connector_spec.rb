RSpec.describe Foobara::RailsCommandConnector do
  start_rails

  context "when using run action", type: :request do
    it "can hit a URL" do
      get "/test_suite/run/CalculateExponent", params: { exponent: 3, base: 2 }
      expect(response.status).to eq(200)
      expect(response.body).to eq("8")
    end
  end

  context "when using help action", type: :request do
    it "can hit a URL" do
      get "/test_suite/help/CalculateExponent"
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>CalculateExponent</h1>")
    end
  end
end
