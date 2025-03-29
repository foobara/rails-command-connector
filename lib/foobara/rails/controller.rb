class Foobara::RailsController < ApplicationController
  include ActionController::Cookies

  before_action :run_and_set_foobara_response

  def run
  end

  def help
  end

  def list
  end

  def describe
  end

  def manifest
  end

  # TODO: add list and describe and manifest if it is different from describe

  private

  def run_and_set_foobara_response
    foobara_response = command_connector.run(self)

    foobara_response.headers.each_pair do |key, value|
      response.set_header(key, value)
    end

    foobara_response.cookies&.each do |cookie|
      cookie_hash = { value: cookie.value }

      cookie_hash[:path] = cookie.path if cookie.path
      cookie_hash[:httponly] = cookie.httponly if cookie.httponly
      cookie_hash[:secure] = cookie.secure if cookie.secure
      cookie_hash[:same_site] = cookie.same_site if cookie.same_site
      cookie_hash[:domain] = cookie.domain if cookie.domain
      cookie_hash[:expires] = cookie.expires if cookie.expires
      cookie_hash[:max_age] = cookie.max_age if cookie.max_age

      cookies[cookie.name] = cookie_hash
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
