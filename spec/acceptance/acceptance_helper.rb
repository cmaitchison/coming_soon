require 'spec_helper'
require 'capybara/rspec'

Spork.prefork do
  RSpec.configure do |config|
    config.after(:each) do
      DatabaseCleaner.clean_with(:truncation)
    end
  end
end