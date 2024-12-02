require "foobara/rack_connector"
require_relative "rails_command_connector/request"

module Foobara
  module CommandConnectors
    class RailsCommandConnector < Foobara::CommandConnectors::Http::Rack
      class << self
        # TODO: push this up the stack
        def supported_actions
          %i[run help describe list]
        end
      end

      attr_accessor :supported_actions

      # TODO: push these default serializers up into the base class
      def initialize(*, supported_actions: self.class.supported_actions, **opts, &)
        self.supported_actions = supported_actions

        opts[:default_serializers] ||= [
          Foobara::CommandConnectors::Serializers::ErrorsSerializer,
          Foobara::CommandConnectors::Serializers::JsonSerializer
        ]

        super(*, **opts, &)

        install!
      end

      def install!
        return if @installed

        @installed = true

        attach_to_rails_application_config!
        install_controller!
        install_routes!
      end

      def attach_to_rails_application_config!
        Rails.application.config.foobara_command_connector = self
      end

      def install_routes!
        prefix = self.prefix
        connector = self

        Rails.application.routes.draw do
          connector.supported_actions.each do |action|
            match "#{prefix}/#{action}/*args", to: "foobara/rails##{action}",
                                               via: %i[get post patch put delete]
          end
        end
      end

      def install_controller!
        require "foobara/rails/controller"
      end
    end
  end
end
