source "https://rubygems.org"
ruby File.read("#{__dir__}/.ruby-version")

gemspec

gem "foobara-dotenv-loader"

gem "rake"

group :development do
  gem "foob"
  gem "foobara-rubocop-rules"
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
  test_app_gemfile_contents = File.read("spec/fixtures/rails-test-app/Gemfile")
  test_app_gemfile_contents = test_app_gemfile_contents.gsub(/^.*foobara-rails-command-connector.*\n/, "")
  File.write("tmp/TestAppGemfile", test_app_gemfile_contents)
  eval_gemfile "tmp/TestAppGemfile"

  gem "rspec-rails"

  gem "foobara-spec-helpers"
  gem "rspec"
  gem "rspec-its"
  gem "ruby-prof"
  gem "simplecov"
  gem "vcr"
  gem "webmock"
end
