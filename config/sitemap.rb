# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://kominka.me"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  

  add buy_index_path
  add buy_prefectures_path
  Prefecture.find_each do |buy_prefecture|
    add buy_prefecture_path(buy_prefecture.id)
  end

  Ebisu::Article.published.all.each do |article|
    add Ebisu::Engine.routes.url_helpers.article_path(article)
  end
  Ebisu::Category.all.each do |category|
    add Ebisu::Engine.routes.url_helpers.category_path(category)
  end



end