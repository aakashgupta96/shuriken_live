# Load the Rails application.
require File.expand_path('../application', __FILE__)
require "rmagick"
require 'koala'
# Initialize the Rails application.

Rails.application.initialize!

require 'carrierwave/orm/activerecord'
require 'frame'
require "RMagick"
Resque.enqueue(StopStream)
