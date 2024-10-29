require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

# rubocop:disable Rails/RakeEnvironment
task :environment do
  require_relative "boot"
end
# rubocop:enable Rails/RakeEnvironment
