#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ComingSoon::Application.load_tasks

# doing this for production breaks asset compilation
unless ENV['RAILS_ENV'] == 'production'
  Rake::Task[:default].clear
  task :default => :run_all_specs
end