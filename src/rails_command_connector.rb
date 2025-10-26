require "foobara/rack_connector"
require_relative "rails_command_connector/request"

module Foobara
  module CommandConnectors
    class RailsCommandConnector < Foobara::CommandConnectors::Http::Rack
      class << self
        # TODO: push this up the stack
        def supported_actions
          [:run, :help, :describe, :list, :manifest]
        end

        def installed?
          @installed
        end

        def mark_installed!
          @installed = true
        end
      end

      attr_accessor :supported_actions

      def initialize(*, supported_actions: self.class.supported_actions, **, &)
        self.supported_actions = supported_actions

        super(*, **, &)

        install!
      end

      def install!
        return if self.class.installed?

        self.class.mark_installed!

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
                                               via: [:get, :post, :patch, :put, :delete]
            match "#{prefix}/#{action}", to: "foobara/rails##{action}",
                                         via: [:get, :post, :patch, :put, :delete],
                                         defaults: { args: "" }
          end
        end
      end

      def install_controller!
        require "foobara/rails/controller"
      end
    end
  end
end
