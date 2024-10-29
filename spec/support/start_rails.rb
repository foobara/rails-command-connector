module Foobara
  module RSpec
    class << self
      def rails_started?
        @_rails_started
      end

      def mark_started!
        @_rails_started = true
      end

      def start_rails!
        return if Foobara::RSpec.rails_started?

        Foobara::RSpec.mark_started!

        ENV["RAILS_ENV"] = "test"

        require_relative "../fixtures/rails-test-app/config/environment"
        require "rspec/rails"
      end
    end

    module ClassMethods
      def start_rails
        before(:all) { Foobara::RSpec.start_rails! }
      end
    end
  end
end

RSpec.configure do |config|
  config.extend Foobara::RSpec::ClassMethods
end
