# Foobara::RailsCommandConnector

A command connector for Foobara that exposes commands via a shell command-line interface (CLI). This connector parses command-line arguments and routes them to Foobara commands, making it easy to build CLI tools from your Foobara commands.

## Installation

Add `gem "foobara-rails-command-connector"` to your Gemfile.

## Usage

### Option 1: Use the connector directly from a file in config/initializers

```ruby
require "foobara/rails_command_connector"

connector = Foobara::CommandConnectors::RailsCommandConnector.new

connector.connect(CreateCapybara)
connector.connect(IncrementAge)
connector.connect(FindCapybara)
```

### Option 2: Expose commands using `command` when drawing routes

This `command` method just calls `CommandConnector#connect` under the hood. It supports
the same DSL and all the same features. It just gives a way for routes created in this manner to
live with your non-Foobara routes.

```ruby
require "foobara/rails_command_connector"
Foobara::CommandConnectors::RailsCommandConnector.new
require "foobara/rails/routes"

Rails.application.routes.draw do
  command CreateCapybara
  command IncrementAge
  command FindCapybara
end
```

Once you have done one of these options, you can view your commands at `/help` and run
your commands from `/run`. You can then import your commands into other systems using
the `foobara-remote-imports` gem and pointing it at `/manifest`. You can generate a
Typescript SDK with `foob g foob g typescript-remote-commands --manifest-url http://localhost:3000/manifest`
or forms with
`foob g typescript-react-command-form --manifest-url http://localhost:3000/manifest --command CreateCommand`.

## Development

### Contributing

Filing bug reports or reporting any issues with using this or any foobara gem would be mighty helpful and appreciated!

If you would like to help contributing art/code/documentation/whatever please get in touch!

### Contributing code

You should be able to fork the repo, clone it locally, run `bundle` and then `rake` to run
the test suite and linter. Make your changes and push them up and open a PR!
If you need any help, please reach out and we're happy to help!

## Licensing

foobara-rails-command-connector is licensed under the Mozilla Public License Version 2.0.
Please see LICENSE.txt for more info.
