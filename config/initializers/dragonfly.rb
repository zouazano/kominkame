require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "6a841ad72bfe7ebead3d2cb33e76393ecbe994aebf04fc2f36aab3e7971a86e1"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
ActiveSupport.on_load(:active_record) do
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations
end
