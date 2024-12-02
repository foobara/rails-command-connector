class Foobara::RailsController < ApplicationController
  before_action :run_and_set_foobara_response

  def run
  end

  def help
    #     render html: foobara_response.body.html_safe, status: foobara_response.status
  end

  def list
  end

  def describe
  end

  # TODO: add list and describe and manifest if it is different from describe

  private

  def run_and_set_foobara_response
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    format = if response.content_type == "application/json"
               :json
             else
               :html
             end

    body = foobara_response.body
    # rubocop:disable Rails/OutputSafety
    body = body.html_safe if format == :html
    # rubocop:enable Rails/OutputSafety

    render format => body, status: foobara_response.status
  end

  def command_connector
    Rails.application.config.foobara_command_connector
  end
end
