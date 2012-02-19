# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ComingSoon::Application.initialize!
APP_CONFIG = YAML.load_file(File.join(Rails.root, "config", "app_config.yml"))