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

  context "when using command DSL method" do
    let(:original_connector) { Rails.application.config.foobara_command_connector }

    around do |example|
      # Save and restore the connector to avoid affecting other tests
      original = Rails.application.config.foobara_command_connector
      begin
        example.run
      ensure
        Rails.application.config.foobara_command_connector = original
      end
    end

    it "automatically creates a connector if one doesn't exist" do
      Rails.application.config.foobara_command_connector = nil
      expect(Rails.application.config.foobara_command_connector).to be_nil

      mapper = ActionDispatch::Routing::Mapper.new(Rails.application.routes)
      mapper.command(:CalculateExponent)

      expect(Rails.application.config.foobara_command_connector).to be_a(Foobara::CommandConnectors::RailsCommandConnector)
    end

    it "uses existing connector if one is already present" do
      existing_connector = Foobara::CommandConnectors::RailsCommandConnector.new(prefix: ["custom"], skip_install: true)
      existing_connector.attach_to_rails_application_config!
      Rails.application.config.foobara_command_connector = existing_connector

      mapper = ActionDispatch::Routing::Mapper.new(Rails.application.routes)
      mapper.command(:CalculateExponent)

      expect(Rails.application.config.foobara_command_connector).to eq(existing_connector)
      # Prefix is stored as a path string, not an array
      expect(Rails.application.config.foobara_command_connector.prefix.to_s).to eq("/custom")
    end

    it "creates connector with default settings when auto-creating" do
      Rails.application.config.foobara_command_connector = nil
      expect(Rails.application.config.foobara_command_connector).to be_nil

      mapper = ActionDispatch::Routing::Mapper.new(Rails.application.routes)
      mapper.command(:CalculateExponent)

      connector = Rails.application.config.foobara_command_connector
      expect(connector).to be_a(Foobara::CommandConnectors::RailsCommandConnector)
      # Default prefix is empty, which becomes an empty string path
      expect(connector.prefix.to_s).to eq("")
    end
  end
end
