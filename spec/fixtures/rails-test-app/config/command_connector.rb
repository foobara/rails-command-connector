require "foobara/rails_command_connector"

connector = Foobara::CommandConnectors::RailsCommandConnector.new(prefix: [ "test_suite" ])

require "foobara/rails/routes"

Rails.application.config.after_initialize do
  # connector.connect(CalculateExponent)
end
