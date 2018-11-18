require 'open-uri'
require 'nokogiri'
require 'csv'


class BuyHouseCrawlerSuumo
  def self.crawl
    kominka = []
    (1..7).each do |num|

      if num == 1
        url = "https://suumo.jp/b/kodate/kw/%E5%8F%A4%E6%B0%91%E5%AE%B6%E3%80%80%E7%89%A9%E4%BB%B6/?sort=9&shubetsu=021"
      else
        url = "https://suumo.jp/b/kodate/kw/%E5%8F%A4%E6%B0%91%E5%AE%B6%E3%80%80%E7%89%A9%E4%BB%B6/#{num}/?sort=9&shubetsu=021"
      end

      user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
      charset = nil

      html = open(url) do |f|
        charset = f.charset
        f.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)

      doc.xpath('//div[@class="cassette-titlebox-item"]').each do |node|
        if node.css('a').inner_text.present?
          kominka << node.css('a').attribute('href').value
        else
        end
      end
    end
    kominka
  end


  def self.detail_crawl

    kominka = ["https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189710882.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz190346506.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188542120.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188893403.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz187828467.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz186036126.html?suit=nsuusbsp20121129001"]

    CSV.open("buy_house_suumo.csv", "w") do |csv|
      kominka.first(5).each do |i|
        url = "#{i}"
        user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
        charset = nil

        html = open(url) do |f|
          charset = f.charset
          f.read
        end

        buy_house_info = []

        doc = Nokogiri::HTML.parse(html, nil, charset)

        p doc

      end
    end

  end


  def self.detail_test

    
  end
end





