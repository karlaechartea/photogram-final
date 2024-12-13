#PLACEHOLDER

Cloudinary.config do |config|
  config.cloud_name = ENV.fetch("CLOUDINARY_CLOUD_NAME", "your_cloud_name")
  config.api_key = ENV.fetch("CLOUDINARY_API_KEY", "your_api_key")
  config.api_secret = ENV.fetch("CLOUDINARY_API_SECRET", "your_api_secret")
  config.cdn_subdomain = true
end

CarrierWave.configure do |config|
  config.storage = :file # Use file storage temporarily
  # Uncomment and configure Cloudinary settings when ready
  # config.storage = :cloudinary
  # config.cloudinary_credentials = {
  #   cloud_name: ENV.fetch("CLOUDINARY_CLOUD_NAME"),
  #   api_key: ENV.fetch("CLOUDINARY_API_KEY"),
  #   api_secret: ENV.fetch("CLOUDINARY_API_SECRET")
  # }
end
