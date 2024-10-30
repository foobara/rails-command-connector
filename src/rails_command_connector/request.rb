require "foobara/rack_connector"

module Foobara
  module CommandConnectors
    class RailsCommandConnector < Foobara::CommandConnectors::Http::Rack
      class Request < Foobara::CommandConnectors::Http::Rack::Request
        attr_accessor :controller

        def initialize(controller, prefix: nil)
          self.controller = controller

          super(controller.request.env, prefix:)
        end
      end
    end
  end
end
