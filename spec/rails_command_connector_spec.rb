RSpec.describe Foobara::RailsCommandConnector do
  start_rails

  context "when using run action", type: :request do
    it "can hit a URL" do
      get "/test_suite/run/CalculateExponent", params: { exponent: 3, base: 2 }
      expect(response.status).to eq(200)
      expect(response.parsed_body).to eq(8)
    end

    context "when there's a attribute-to-cookie mutator being used" do
      it "moves the attribute to a cookie" do
        get "/test_suite/run/FooBarBaz"

        expect(response.status).to eq(200)
        expect(response.parsed_body).to eq("bar" => "bar value", "baz" => "baz value")

        expect(response.headers["Set-Cookie"]).to include("foo=foo+value")
      end
    end
  end

  context "when using help action", type: :request do
    it "can hit a URL" do
      get "/test_suite/help/CalculateExponent"
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>CalculateExponent</h1>")
    end
  end

  context "when using list action", type: :request do
    it "can hit a URL" do
      get "/test_suite/list/CalculateExponent"
      expect(response.status).to eq(200)
      expect(response.parsed_body.first.first).to include("CalculateExponent")
    end
  end

  context "when using describe action", type: :request do
    it "can hit a URL" do
      get "/test_suite/describe/CalculateExponent"
      expect(response.status).to eq(200)
      expect(response.parsed_body.key?("inputs_type")).to be true
    end
  end

  context "when using manifest action", type: :request do
    it "can hit a URL" do
      get "/test_suite/manifest/1"
      expect(response.status).to eq(200)
      expect(response.parsed_body.key?("command")).to be true
    end
  end
end
