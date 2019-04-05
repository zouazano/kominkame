Ebisu.configure do |config|
  # The datastore type for dragonfly used in ebisu internally.
  # Available options are: :file or :s3.
  config.image_store_type = :file

  # The configuration for datastore.
  config.image_store_attributes = {
    root_path: Rails.root.join('public', 'system', 'dragonfly', Rails.env),
    server_root: Rails.root.join('public')
  }

  # Information for RSS generator.
  config.rss_feed_title = 'Repairman RSS Feed'
  config.rss_feed_description = "The latest articles in Repairman powered by Ebisu."
  config.logo_url = "#{ENV['IPHONE_REPAIR_HOST']}/logo.png"
  config.google_analytics_id = ENV['GOOGLE_ANALYTICS_ID']
  config.site_name = 'コミンカ(kominka)'
end