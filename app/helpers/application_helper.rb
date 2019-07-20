# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'コミンカ',
      title: '古民家探しはコミンカ',
      reverse: true,
      charset: 'utf-8',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: '古民家物件専門サイト『コミンカ』',
        title: '古民家探しはコミンカ',
        type: 'website',
        url: request.original_url,
        image: image_url('header3文字あり.jpg'),
        locale: 'ja_JP',
      },
    }
  end
end