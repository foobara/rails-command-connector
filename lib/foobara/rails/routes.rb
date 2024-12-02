ActionDispatch::Routing::Mapper.class_eval do
  command_connector = Rails.application.config.foobara_command_connector

  define_method :command do |*args, **opts, &block|
    command_connector.connect(*args, **opts, &block)
  end
end
