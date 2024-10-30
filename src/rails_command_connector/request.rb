require "foobara/rack_connector"

module Foobara
  module CommandConnectors
    class RailsCommandConnector < Foobara::CommandConnectors::Http::Rack
      class Request < Foobara::CommandConnectors::Http::Rack::Request
        attr_accessor :controller

        def initialize(controller)
          self.controller = controller

          binding.pry

          super(controller.request.env)
        end
      end
    end
  end
end
