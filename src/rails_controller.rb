class Foobara::RailsController < ApplicationController
  def run
    RAILS_COMMAND_CONNECTOR.run(self)
  end
end
