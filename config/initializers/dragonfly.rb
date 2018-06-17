require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "c744aa838cd584da29a38f985d8bb0aff4c4c57e1746e84d68afda3278bc7efc"

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
