class Foobara::RailsController < ApplicationController
  def run
    # TODO: automatically put this on Rails.application.config or something
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    render json: foobara_response.body, status: foobara_response.status
  end

  def help
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    # rubocop:disable Rails/OutputSafety
    render html: foobara_response.body.html_safe, status: foobara_response.status
    # rubocop:enable Rails/OutputSafety
  end

  def list
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    render json: foobara_response.body, status: foobara_response.status
  end

  def describe
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    render json: foobara_response.body, status: foobara_response.status
  end

  # TODO: add list and describe and manifest if it is different from describe

  private

  def command_connector
    Rails.application.config.foobara_command_connector
  end
end
