require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "6a841ad72bfe7ebead3d2cb33e76393ecbe994aebf04fc2f36aab3e7971a86e1"

  url_format "/media/:job/:name"
  if Rails.env.development?
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  elsif Rails.env.test?
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  else
    datastore :s3,
      bucket_name: 'rails-photo-carrierwave',
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: 'ap-northeast-1'
  end

  define_url do |app, job, _opts|
    thumb = Thumb.find_by(signature: job.signature)
    # If (fetch 'some_uid' then resize to '40x40') has been stored already, give the datastore's remote url ...
    if thumb
      app.datastore.url_for(thumb.uid)
    # ...otherwise give the local Dragonfly server url
    else
      app.server.url_for(job)
    end
  end

  # Before serving from the local Dragonfly server...
  before_serve do |job, _env|
    # ...store the thumbnail in the datastore...
    uid = job.store

    # ...keep track of its uid so next time we can serve directly from the datastore
    Thumb.create!(uid: uid, signature: job.signature)
  end

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
