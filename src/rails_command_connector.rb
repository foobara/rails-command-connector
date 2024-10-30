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

      # TODO: push this prefix concept into the base class once it is working
      attr_accessor :prefix, :supported_actions

      # TODO: push these default serializers up into the base class
      def initialize(*, prefix: false, supported_actions: self.class.supported_actions, **opts, &)
        self.prefix = prefix
        self.supported_actions = supported_actions

        opts[:default_serializers] ||= [
          Foobara::CommandConnectors::Serializers::ErrorsSerializer,
          Foobara::CommandConnectors::Serializers::JsonSerializer
        ]

        super(*, **opts, &)
      end

      def draw!
        install!
      end

      def install!
        return if @installed

        @installed = true

        install_controller!
        install_routes!
      end

      def install_routes!
        prefix = self.prefix

        normalized_prefix = if prefix
                              if prefix.is_a?(::Array)
                                prefix = prefix.join("/")
                              end

                              unless prefix&.start_with?("/")
                                prefix = "/#{prefix}"
                              end

                              unless prefix&.end_with?("/")
                                prefix = "#{prefix}/"
                              end

                              prefix
                            end
        connector = self

        Rails.application.routes.draw do
          connector.supported_actions.each do |action|
            match "#{normalized_prefix}#{action}/*args", to: "foobara/rails##{action}",
                                                         via: %i[get post patch put delete]
          end
        end
      end

      def install_controller!
        require_relative "rails_controller"
      end
    end
  end
end
