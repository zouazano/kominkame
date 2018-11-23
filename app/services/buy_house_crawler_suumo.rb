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

    kominka = ["https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190423197.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189283371.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz189937175.html?suit=nsuusbsp20121129001"]

    CSV.open("buy_house_suumo.csv", "w") do |csv|
      header = ['name', 'address', 'access', 'madori', 'land_area', 'house_area', 'built_date', 'strong_point', 'prefecture_name', 'price', 'zip_code', 'hours', 'age', 'built_time', 'recommendation', 'notes', 'shop_id', 'source', 'image_url1', 'image_url2', 'image_url3', 'image_url4']
      csv << header
      kominka.each do |i| 
        url = "#{i}"
        user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
        charset = nil

        begin
          html = open(url) do |f|
            charset = f.charset
            f.read
          end
        rescue OpenURI::HTTPError
          sleep 1
          next
        end

        buy_house_info = []

        doc = Nokogiri::HTML.parse(html, nil, charset)

        
        (3..15).each do |n|
          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/th[1]").inner_text == '住所'
            name = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[1]/p[1]").inner_text
            if name.slice(0, 3) == '鹿児島' or name.slice(0, 3) == '和歌山' or name.slice(0, 3) == '神奈川'
              name.slice!(0, 4)
            else
              name.slice!(0, 3)
            end

            address = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[1]/p[1]").inner_text
            buy_house_info.push(name, address)
          elsif doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[6]/th[1]").inner_text == '住所'
            name = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[6]/td[1]/p[1]").inner_text
            if name.slice(0, 3) == '鹿児島' or name.slice(0, 3) == '和歌山' or name.slice(0, 3) == '神奈川'
              name.slice!(0, 4)
            else
              name.slice!(0, 3)
            end

            address = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[6]/td[1]/p[1]").inner_text
            buy_house_info.push(name, address)
            
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/th[2]").inner_text == '交通'
            access = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[2]/div").inner_text
            buy_house_info.push(access)
          elsif doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[6]/th[2]").inner_text == '交通'
            access = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[6]/td[2]/div").inner_text
            buy_house_info.push(access)
          else
          end
          
          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[1]/th[2]/div[1]").inner_text == '間取り'
            madori = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[1]/td[2]/p").inner_text.sub(/\r.*/m, "")
            buy_house_info.push(madori)
          elsif doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[2]/th[2]/div[1]").inner_text == '間取り'
            madori = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[2]/td[2]/p").inner_text.sub(/\r.*/m, "")
            buy_house_info.push(madori)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/th[1]/div[1]").inner_text == '土地面積'
            land_area = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/td[1]/text()[1]").inner_text.gsub(/\m.*/m, "")
            land_area.slice!(0, 9)
            buy_house_info.push(land_area)
          elsif doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/th[1]/div[1]").inner_text == '土地面積'
            land_area = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/td[1]/text()[1]").inner_text.gsub(/\m.*/m, "")
            land_area.slice!(0, 9)
            buy_house_info.push(land_area)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/th[2]/div[1]").inner_text == '建物面積'
            house_area = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/td[2]/text()").inner_text.gsub(/\m.*/m, "")
            house_area.slice!(0, 9)
            buy_house_info.push(house_area)
          elsif doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/th[2]/div[1]").inner_text == '建物面積'
            house_area = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/td[2]/text()").inner_text.gsub(/\m.*/m, "")
            house_area.slice!(0, 9)
            buy_house_info.push(house_area)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/th[2]/div[1]").inner_text == '完成時期（築年月）'
            if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/td[2]").inner_text.include?("月")
              built_date = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/td[2]").inner_text.gsub(/年/m, "-").gsub(/月/m, "").gsub(/\s/m, "")
              buy_house_info.push(built_date)
            else
              built_date = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/td[2]").inner_text.gsub(/年/m, "-1").gsub(/\s/m, "")
              buy_house_info.push(built_date)
            end
          elsif doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/th[2]/div[1]").inner_text == '完成時期（築年月）'
            if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[2]").inner_text.include?("月")
              built_date = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[2]").inner_text.gsub(/年/m, "-").gsub(/月/m, "").gsub(/\s/m, "")
              buy_house_info.push(built_date)
            else
              built_date = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[2]").inner_text.gsub(/年/m, "-1").gsub(/\s/m, "")
              buy_house_info.push(built_date)
            end
          else
          end

        end
        
        strong_point = doc.xpath('//*[@id="mainContents"]/div[2]/h2').inner_text
        prefecture_name = doc.xpath('//*[@id="help_link"]/ul/li[4]/a').inner_text
        price = doc.xpath('//*[@id="topContents"]/div[2]/div[1]/div[2]/p[1]').inner_text.sub(/億/m, "").sub(/万.*/m, "")
        zip_code = ''
        hours = ''
        age = ''
        notes = ''
        recommendation = 'great'
        shop_id = ''
        source = url
        if doc.xpath('//*[@id="imgG02_001"]').present?
          image_url1 = doc.xpath('//*[@id="imgG02_001"]').attribute("src").value
        else 
          image_url1 = ""
        end
        if doc.xpath('//*[@id="imgG02_002"]').present?
          image_url2 = doc.xpath('//*[@id="imgG02_001"]').attribute("src").value
        else 
          image_url2 = ""
        end
        if doc.xpath('//*[@id="imgG02_003"]').present?
          image_url3 = doc.xpath('//*[@id="imgG02_001"]').attribute("src").value
        else 
          image_url3 = ""
        end
        if doc.xpath('//*[@id="imgG02_004"]').present?
          image_url4 = doc.xpath('//*[@id="imgG02_001"]').attribute("src").value
        else 
          image_url4 = ""
        end
       
        
        buy_house_info.push(strong_point, prefecture_name, price, zip_code, hours, age, notes, recommendation, shop_id, source, image_url1, image_url2, image_url3, image_url4)

        csv << buy_house_info
        sleep 2
      end
    end

  end


  def self.detail_test

    
  end
end





