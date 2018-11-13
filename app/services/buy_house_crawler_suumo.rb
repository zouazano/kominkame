require 'open-uri'
require 'nokogiri'
require 'csv'


class BuyHouseCrawlerSuumo
  def self.crawl
    url = 'https://suumo.jp/b/kodate/kw/%E5%8F%A4%E6%B0%91%E5%AE%B6%E3%80%80%E7%89%A9%E4%BB%B6/?sort=9&shubetsu=021'
    titles = []
    charset = nil

    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    doc.xpath('//div[@class="cassette"]').each do |node|
      title = node.css('div[@class="cassette-titlebox-item"]').inner_text
      titles.push(title)
      p node.css('div[@class="cassette-titlebox-item"]').inner_text
    end
  CSV.open("buy_house_crawl_test.csv", "w") do |csv|
    csv << titles
  end
  end
end

