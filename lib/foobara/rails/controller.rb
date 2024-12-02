class Foobara::RailsController < ApplicationController
  def run
    foobara_response.command
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    render json: foobara_response.body, status: foobara_response.status
  end

  private

  def command_connector
    Rails.application.config.foobara_command_connector
  end
end
