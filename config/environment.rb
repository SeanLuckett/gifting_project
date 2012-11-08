# Load the rails application
require File.expand_path('../application', __FILE__)

#Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

# Set mailer default host.
config.action_mailer.default_url_options = {:host => 'giftola.herokuapp.com'}

# Initialize the rails application
Giftola::Application.initialize!
