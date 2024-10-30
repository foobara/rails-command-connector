class Foobara::RailsController < ApplicationController
  def run
    foobara_response = RAILS_COMMAND_CONNECTOR.run(self)
    foobara_response.command

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    render json: foobara_response.body, status: foobara_response.status
  end
end
