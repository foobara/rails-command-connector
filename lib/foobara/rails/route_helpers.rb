ActionDispatch::Routing::Mapper.class_eval do
  define_method :command do |*args, **opts, &block|
    HTTP_COMMAND_CONNECTOR.connect(*args, **opts, &block)
  end
end
