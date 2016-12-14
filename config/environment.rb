# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'rmagick'
require 'sidekiq'
# Initialize the Rails application.

Sidekiq.configure_client do |config|
	config.redis = {db: 1}
end

Sidekiq.configure_server do |config|
	config.redis = {db: 1}
end

Rails.application.initialize!
