# Load the Rails application.
require_relative "application"
require "carrierwave"
require "carrierwave/orm/activerecord"
require "cloudinary"
require "carrierwave/storage/cloudinary"

# Initialize the Rails application.
Rails.application.initialize!
