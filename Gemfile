require_relative "version"

source "https://rubygems.org"
ruby Foobara::RailsCommandConnector::MINIMUM_RUBY_VERSION

gemspec

gem "foobara-dotenv-loader", "< 2.0.0"

gem "rake"

group :development do
  gem "foob"
  gem "foobara-rubocop-rules", ">= 1.0.0"
  gem "guard-rspec"
  # Adding these because -omakase is required by the test
  # app and things blow up in CI without rubocop-rails for some reason
  gem "rubocop-rails"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
end

group :test do
  # This loads the dependencies for the test app since it runs in memory when we run the test suite
  test_app_gemfile_contents = File.read("spec/fixtures/rails-test-app/Gemfile")
  test_app_gemfile_contents = test_app_gemfile_contents.gsub(/^.*foobara-rails-command-connector.*\n/, "")
  test_app_gemfile_contents = test_app_gemfile_contents.gsub(/, path: "(.*)\/\.\.\/\.\./, ', path: "\1')
  File.write("tmp/TestAppGemfile", test_app_gemfile_contents)
  eval_gemfile "tmp/TestAppGemfile"

  gem "rspec-rails"

  gem "foobara-spec-helpers", "< 2.0.0"
  gem "rspec"
  gem "rspec-its"
  gem "ruby-prof"
  gem "simplecov"
  gem "vcr"
  gem "webmock"
end
