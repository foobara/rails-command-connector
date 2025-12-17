ActionDispatch::Routing::Mapper.class_eval do
  define_method :command do |*args, **opts, &block|
    command_connector = Rails.application.config.foobara_command_connector

    unless command_connector
      require "foobara/rails_command_connector"
      command_connector = Foobara::CommandConnectors::RailsCommandConnector.new
      # Ensure the connector is attached to config even if install! was skipped
      # (e.g., if installation was already done by a previous connector)
      # We check again in case install! attached a different instance (shouldn't happen, but safe)
      command_connector.attach_to_rails_application_config! if Rails.application.config.foobara_command_connector.nil?
    end

    command_connector.connect(*args, **opts, &block)
  end
end
