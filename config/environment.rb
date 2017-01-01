# Load the Rails application.
require File.expand_path('../application', __FILE__)
require "rmagick"
require 'koala'
require 'carrierwave/orm/activerecord'
require 'frame'
Rails.application.initialize!

#Resque.enqueue(StopStream)
