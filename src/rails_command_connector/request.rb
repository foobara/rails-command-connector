module Foobara
  module CommandConnectors
    class RailsCommandConnector < CommandConnectors::Http
      class Request < CommandConnectors::Http::Request
        attr_accessor :controller

        def initialize(controller)
          self.controller = controller

          super(controller.request.env)
        end
      end
    end
  end
end
