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
  gem "rubocop-rails-omakase"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
end

group :test do
  gem "foobara-spec-helpers"
  gem "rspec"
  gem "rspec-its"
  gem "ruby-prof"
  gem "simplecov"
  gem "vcr"
  gem "webmock"
end
