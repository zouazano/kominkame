require 'open-uri'
require 'nokogiri'
require 'csv'


class AkiyaBankCrawler
  def self.hokkaido
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36"
    charset = nil
    
    [1208, 1193, 1180, 1147, 1182, 1185, 1179, 1178, 1173, 1135, 1108, 1068, 1069, 1070, 1054, 1066, 1058, 1055, 980, 726, 866, 1005, 972, 944, 459, 902, 454, 456, 842, 79, 77, 556, 480, 584, 599, 13, 209].each do |num|
      
      link = "https://www.hokkaido-akiya.com" + "/detail?id=#{num}"
      link_doc = Nokogiri::HTML(open(link, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
      name = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[10]/td').inner_text&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')&.gsub(/\d.+/, "")
      prefecture_id = 1
      price_tag = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[5]/td').inner_text&.gsub(",", "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
      unless price_tag == nil
        price = price_tag.to_i/10000
      else
        price = price_tag
      end
      address = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[10]/td').inner_text
      access = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[2]/tbody/tr[1]/td').inner_text
      madori = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[11]/td/text()').inner_text&.gsub(/\r\n|\r|\n|\s|\t/, "")
      land_area = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[12]/td').inner_text&.gsub(",", "")&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')&.gsub(/[㎡].+/, "")
      built_date = link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[15]/td').inner_text
      if built_date&.include?("平成")
        built_date = (built_date.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/].to_i + 1988).to_s + "-01-01"
      elsif built_date&.include?("昭和")
        built_date = (built_date.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/].to_i + 1925).to_s + "-01-01"            
      end
      notes_array = []
      notes_array << link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[1]/tbody/tr[24]/td')&.inner_text&.gsub(" ", "")&.gsub(/\n+/, ",")&.gsub(/\r\n|\r|\n|\s|\t/, "")
      notes_array << link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[3]/tbody')&.inner_text&.gsub(" ", "")&.gsub(/\n+/, ",")&.gsub(/\r\n|\r|\n|\s|\t/, "")
      notes_array << link_doc.xpath('//*[@id="main"]/div[3]/div[2]/section/table[4]/tbody')&.inner_text&.gsub(" ", "")&.gsub(/\n+/, ",")&.gsub(/\r\n|\r|\n|\s|\t/, "")

      notes = notes_array.join(", ")

      recommendation = "great"
      source = link

      image_url_1 = link_doc.xpath('//*[@id="main"]/div[3]/div[1]/section/p[1]/a/img')&.attribute('src')&.value
      unless image_url_1 == nil
        image_url1 = "https://www.hokkaido-akiya.com" + image_url_1
      else
        image_url1 = image_url_1
      end
      image_url_2 = link_doc.xpath('//*[@id="main"]/div[3]/div[1]/section/p[2]/a[1]/img')&.attribute('src')&.value
      unless image_url_2 == nil
        image_url2 = "https://www.hokkaido-akiya.com" + image_url_2
      else
        image_url2 = image_url_2
      end
      image_url_3 = link_doc.xpath('//*[@id="main"]/div[3]/div[1]/section/p[2]/a[2]/img')&.attribute('src')&.value
      unless image_url_3 == nil
        image_url3 = "https://www.hokkaido-akiya.com" + image_url_3
      else
        image_url3 = image_url_3
      end
      image_url_4 = link_doc.xpath('//*[@id="main"]/div[3]/div[1]/section/p[2]/a[3]/img')&.attribute('src')&.value
      unless image_url_4 == nil
        image_url4 = "https://www.hokkaido-akiya.com" + image_url_4
      else
        image_url4 = image_url_4
      end

      buy_house = BuyHouse.where(name: name).where(price: price).where(source: source).first
      if buy_house.present?
        next
      else
        buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, built_date: built_date, notes: notes, recommendation: recommendation, source: source)
        buy_house.save
      end

      
      sleep 2
    end
  end

  def self.iwate
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil
    
    (1..3).each do |num|
      url = "https://www.homes.co.jp/akiyabank/tohoku/iwate?category%5B0%5D=101&page=#{num}"
      doc = Nokogiri::HTML(open(url))
      doc.xpath('//*[@id="searchResultList"]/div[1]/div').each do |div|
        link = div.xpath('a')&.attribute('href')&.value
        link_doc = Nokogiri::HTML(open(link))
        name = link_doc.xpath('//div[contains(@class, "mod-bukkenJyouhou")]/div/table/tbody/tr[1]/td[1]').inner_text.gsub(" ", "")&.gsub("岩手県", "")&.gsub(/\n/, "")
        prefecture_id = 3
        price_tag = link_doc.xpath('//div[contains(@class, "mod-bukkenJyouhou")]/div/table/tbody/tr[1]/td[2]').inner_text&.gsub(",", "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
        unless price_tag == nil
          price = price_tag.to_i/10000
        else
          price = price_tag
        end
        address = name
        access = link_doc.xpath("//tr[contains(.,'交通')]")&.inner_text&.gsub(" ", "")&.gsub(/\n/, "")
        madori = link_doc.xpath("//th[contains(.,'間取り')]/following-sibling::td[1]")&.inner_text&.gsub(" ", "")&.gsub(/\n/, "")
        land_area = link_doc.xpath("//tr[contains(.,'土地面積')]/td[contains(., '㎡')]").inner_text&.gsub(",", "")&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
        house_area = link_doc.xpath("//tr[contains(.,'建物面積')]/td[contains(., '㎡')]").inner_text&.gsub(",", "")&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
        unless link_doc.xpath("//tr[contains(.,'築年')]/td[contains(., '年')]").inner_text&.gsub(" ", "")&.gsub(/\n/, "")&.gsub(/月.*/, "").slice(/(.*)(?=年)/) == nil
          built_date = link_doc.xpath("//tr[contains(.,'築年')]/td[contains(., '年')]").inner_text&.gsub(" ", "")&.gsub(/\n/, "")&.gsub(/月.*/, "").slice(/(.*)(?=年)/)&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z') + "-" + link_doc.xpath("//tr[contains(.,'築年')]/td[contains(., '年')]").inner_text&.gsub(" ", "")&.gsub(/\n/, "")&.gsub(/月.*/, "").slice(/年.*/)&.gsub("年", "")&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z') + "-01"
        else
          built_date = nil
        end
        notes_array = []
        notes_array << link_doc.xpath('//div[contains(@class, "mod-bukkenAround")]/div/table/tbody')&.inner_text&.gsub(" ", "")&.gsub(/\n+/, ",")
        notes_array << link_doc.xpath('//div[contains(@class, "mod-bukkenSetsubi")]')&.inner_text&.gsub(" ", "")&.gsub(/\n+/, ",")
        notes_array << link_doc.xpath('//div[contains(@class, "mod-bukkenGaiyou")]/div/table/tbody')&.inner_text&.gsub(" ", "")&.gsub(/\n+/, ",")

        notes = notes_array.join(", ")

        recommendation = "great"
        source = link

        image_url1 = link_doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[1]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        image_url2 = link_doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[2]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        image_url3 = link_doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[3]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        image_url4 = link_doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[4]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")

        buy_house = BuyHouse.where(name: name).where(price: price).where(source: source).first
        if buy_house.present?
          next
        else
          buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, built_date: built_date, notes: notes, recommendation: recommendation, source: source)
          buy_house.save
        end

        if buy_house.save
          if image_url1&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url1)
            sleep 2
          end
          if image_url2&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url2)
            sleep 2
          end
          if image_url3&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url3)
            sleep 2
          end
          if image_url4&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url4)
            sleep 2
          end
        end
        sleep 2
      end
    end
  end

  def self.shizuoka
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil
    
    (1..5).each do |num|
      url = "https://iju.pref.shizuoka.jp/estatelist.html?status%255B0%255D=1&house_area=0&house_city=0&limit=10&page=#{num}&offset=0"
      doc = Nokogiri::HTML(open(url))
      doc.xpath('//div[contains(@class, "estateResultListInner")]').each do |div|
        unless div.xpath('div[2]/*[@id="saleTab"]/tbody/tr/th[2]/em').inner_text == ""
          link = "https://iju.pref.shizuoka.jp/" + div.xpath('div[1]/a')&.attribute('href')&.value
          link_doc = Nokogiri::HTML(open(link))
          name = link_doc.xpath('//*[@id="specification"]/tr[1]/td').inner_text&.gsub("静岡県", "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')&.gsub(/[\d+].+/, "")
          prefecture_id = 22
          price = link_doc.xpath('//*[@id="saleTab"]/tr/td[2]/em').inner_text&.gsub(",", "") { |match|  }.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
          address = link_doc.xpath('//*[@id="specification"]/tr[1]/td').inner_text&.gsub("静岡県", "")
          land_area = link_doc.xpath('//*[@id="specification"]/tr[2]/td').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
          house_area = link_doc.xpath('//*[@id="specification"]/tr[3]/td').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
          date = link_doc.xpath('//*[@id="specification"]/tr[4]/td[2]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
          unless date == nil
            built_date = date + "-01-01"
          else
            built_date = date
          end
          notes_array = []
          link_doc.xpath('//*[@id="specification"]/tr[position() > 4]').each do |tr|
            notes_array << tr.inner_text&.gsub(/\t/, "")&.gsub(/\n/, ":")
          end
          notes = notes_array.join(", ")
          recommendation = "great"
          source = link
          image_url_1 = link_doc.xpath('//*[@id="menu"]/ul/li[1]/a/img')&.attribute('src')&.value&.gsub("type=3", "type=2")
          unless image_url_1 == nil
            image_url1 = "https://iju.pref.shizuoka.jp" + image_url_1
          else
            image_url1 = image_url_1
          end
          image_url_2 = link_doc.xpath('//*[@id="menu"]/ul/li[2]/a/img')&.attribute('src')&.value&.gsub("type=3", "type=2")
          unless image_url_2 == nil
            image_url2 = "https://iju.pref.shizuoka.jp" + image_url_2
          else
            image_url2 = image_url_2
          end
          image_url_3 = link_doc.xpath('//*[@id="menu"]/ul/li[3]/a/img')&.attribute('src')&.value&.gsub("type=3", "type=2")
          unless image_url_3 == nil
            image_url3 = "https://iju.pref.shizuoka.jp" + image_url_3
          else
            image_url3 = image_url_3
          end
          image_url_4 = link_doc.xpath('//*[@id="menu"]/ul/li[4]/a/img')&.attribute('src')&.value&.gsub("type=3", "type=2")
          unless image_url_4 == nil
            image_url4 = "https://iju.pref.shizuoka.jp" + image_url_4
          else
            image_url4 = image_url_4
          end

          buy_house = BuyHouse.where(name: name).where(price: price).where(source: source).first
          if buy_house.present?
            next
          else
            buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, land_area: land_area, house_area: house_area, built_date: built_date, notes: notes, recommendation: recommendation, source: source)
            buy_house.save
          end

          if buy_house.save
            buy_house.buy_house_images.create(buy_house_image_url: image_url1)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url2)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url3)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url4)
            sleep 2
          end
          sleep 2
          
        end
        
      end
    end
  end


  def self.kanagawa
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil
    
    (0..13).each do |num|
      url = "https://enjoystyles.jp/index.php?c=search&category_ids=4&p=#{num}#listMenu"
      doc = Nokogiri::HTML(open(url))
      doc.xpath("//div[contains(@class, 'list-details')]").each do |div|
        link = "https://enjoystyles.jp/" + div.xpath('a')&.attribute('href')&.value
        link_doc = Nokogiri::HTML(open(link))
        if link_doc.xpath('//*[@id="saleOrRent"]/img')&.attribute('alt')&.value == "Sale"
          name = link_doc.xpath('//*[@id="bukkenTitle"]/h2').inner_text
          prefecture_id = 14
          price = link_doc.xpath('//*[@id="bukkenTitle"]/dl/dd').inner_text.gsub(/(.*)(?=㎡)/,"").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
          address = name
          access = link_doc.xpath('//*[@id="dataList"]/dl/dd[1]').inner_text
          madori = link_doc.xpath('//*[@id="dataList"]/dl/dd[12]').inner_text
          land_area = link_doc.xpath('//*[@id="dataList"]/dl/dd[2]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
          house_area = link_doc.xpath('//*[@id="dataList"]/dl/dd[3]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
          notes = link_doc.xpath('//*[@id="dataList"]/dl/dd[22]').inner_text
          recommendation = "great"
          source = link

          image_url1 = "https://enjoystyles.jp/" + link_doc.xpath('//*[@id="clickPhotoList"]/ul/li[1]/img')&.attribute('src')&.value
          image_url2 = "https://enjoystyles.jp/" + link_doc.xpath('//*[@id="clickPhotoList"]/ul/li[2]/img')&.attribute('src')&.value
          image_url3 = "https://enjoystyles.jp/" + link_doc.xpath('//*[@id="clickPhotoList"]/ul/li[3]/img')&.attribute('src')&.value
          image_url4 = "https://enjoystyles.jp/" + link_doc.xpath('//*[@id="clickPhotoList"]/ul/li[4]/img')&.attribute('src')&.value

          buy_house = BuyHouse.where(name: name).where(price: price).where(access: access).first
          if buy_house.present?
            next
          else
            buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, notes: notes, recommendation: recommendation, source: source)
            buy_house.save
          end

          if buy_house.save
            buy_house.buy_house_images.create(buy_house_image_url: image_url1)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url2)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url3)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url4)
            sleep 2
          end
          sleep 2
        end
      end
    end
  end


  def self.mie
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil
    
    url = "http://www.ijyu.pref.mie.lg.jp/html/akiya_list.php"
    doc = Nokogiri::HTML(open(url))
    doc.xpath('//*[@id="akiya_list"]/tr[position() > 2]').each do |tr|
      if tr.xpath('td[3]').inner_text == "売却"
        prefecture_id = 24
        name = tr.xpath('td[1]/div').inner_text
        image_url1 = tr.xpath('td[2]//img')&.attribute('src')&.value
        price = tr.xpath('td[4]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/]
        address = name
        land_area = nil
        house_area = nil
        recommendation = "great"
        tr.xpath('td[5]/text()').each do |text|
          if text&.inner_text&.include?("敷")
            land_area = text.inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
          elsif text&.inner_text&.include?("延")
            house_area = text.inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
          elsif text&.inner_text&.include?("建")
            house_area = text.inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+\.?\d*/]
          end
        end
        source = tr.xpath('td[8]/a').attribute('href').value
        notes = tr.xpath('td[6]').inner_text.gsub("交渉中", "")

        buy_house = BuyHouse.where(name: name).where(price: price).where(land_area: land_area).first
        if buy_house.present?
          buy_house.update(source: source)
          next
        else
          buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, land_area: land_area, house_area: house_area, notes: notes, recommendation: recommendation, source: source)
          buy_house.save
        end

        if buy_house.save
          buy_house.buy_house_images.create(buy_house_image_url: image_url1)
          sleep 2
        end
        sleep 2

      end
    end
  end


  def self.hiroshima
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil

    (1..18).each_with_index do |num, i|
      unless i == 1
        url = "http://minto-hiroshima.jp/akiya/page/#{num}/#akiya_archive"
      else
        url = "http://minto-hiroshima.jp/akiya/#akiya_archive"
      end
      doc = Nokogiri::HTML(open(url))
      doc.xpath('//*[@id="akiya_archive"]/ul/li').each do |node|
        link = node.xpath('div/a').attribute('href').value
        link_doc = Nokogiri::HTML(open(link))
        if link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[2]/td').inner_text == "売家"
          name = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[1]/td').inner_text
          prefecture_id = 34
          price = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[3]/td').inner_text.slice(0..-3)
          address = name
          access = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[10]/td/p').inner_text
          madori = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[7]/td').inner_text
          land_area = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[5]/td').inner_text&.slice(0..-2)
          house_area = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[6]/td').inner_text&.slice(0..-2)
          notes = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[9]').inner_text.gsub(" ", "") + link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[position() > 10]').inner_text.gsub(" ", "")
          recommendation = "great"
          source = link
          image_url1 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[1]/a/img')&.attribute('src')&.value
          image_url2 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[2]/a/img')&.attribute('src')&.value
          image_url3 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[3]/a/img')&.attribute('src')&.value
          image_url4 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[last()]/a/img')&.attribute('src')&.value
          built_date = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[8]/td').inner_text
          if built_date&.include?("昭和")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1925).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1925).to_s + "-01-01"
            end
          elsif built_date&.include?("平成")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1988).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1988).to_s + "-01-01"
            end
          elsif built_date&.include?("大正")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1911).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1911).to_s + "-01-01"
            end
          elsif built_date&.include?("明治")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1867).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1867).to_s + "-01-01"
            end
          elsif built_date[/\d+/].present?
            if built_date.slice(/年.*/)&.include?("月")
              built_date = built_date.gsub(/年.*/, "")[/\d+/] + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = built_date.gsub(/年.*/, "")[/\d+/] + "-01-01"
            end
          end

          buy_house = BuyHouse.where(name: name).where(price: price).where(access: access).first
          if buy_house.present?
            buy_house.update(source: source)
            next
          else
            buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, notes: notes, recommendation: recommendation, source: source, built_date: built_date)
            buy_house.save
          end

          if buy_house.save
            buy_house.buy_house_images.create(buy_house_image_url: image_url1)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url2)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url3)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url4)
            sleep 2
          end
          sleep 2

        elsif link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[2]/td').inner_text&.include?("売")
          name = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[1]/td').inner_text
          prefecture_id = 34
          price = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[3]/td').inner_text.gsub(/万円.*/, "")[/\d+/]
          address = name
          access = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[10]/td/p').inner_text
          madori = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[7]/td').inner_text
          land_area = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[5]/td').inner_text&.slice(0..-2)
          house_area = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[6]/td').inner_text&.slice(0..-2)
          notes = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[9]').inner_text.gsub(" ", "") + link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[position() > 10]').inner_text.gsub(" ", "")
          recommendation = "great"
          source = link
          image_url1 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[1]/a/img')&.attribute('src')&.value
          image_url2 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[2]/a/img')&.attribute('src')&.value
          image_url3 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[3]/a/img')&.attribute('src')&.value
          image_url4 = link_doc.xpath('//*[@id="akiya_single_gallery"]/li[last()]/a/img')&.attribute('src')&.value
          built_date = link_doc.xpath('/html/body/div[2]/div/div/div[2]/table/tbody/tr[8]/td').inner_text
          if built_date&.include?("昭和")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1925).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1925).to_s + "-01-01"
            end
          elsif built_date&.include?("平成")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1988).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1988).to_s + "-01-01"
            end
          elsif built_date&.include?("大正")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1911).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1911).to_s + "-01-01"
            end
          elsif built_date&.include?("明治")
            if built_date.slice(/年.*/)&.include?("月")
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1867).to_s + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = (built_date.gsub(/年.*/, "")[/\d+/].to_i + 1867).to_s + "-01-01"
            end
          elsif built_date[/\d+/].present?
            if built_date.slice(/年.*/)&.include?("月")
              built_date = built_date.gsub(/年.*/, "")[/\d+/] + "-" + built_date.slice(/年.*/)[/\d+/] + "-01"
            else
              built_date = built_date.gsub(/年.*/, "")[/\d+/] + "-01-01"
            end
          end

          buy_house = BuyHouse.where(name: name).where(price: price).where(access: access).first
          if buy_house.present?
            buy_house.update(source: source)
            next
          else
            buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, notes: notes, recommendation: recommendation, source: source, built_date: built_date)
            buy_house.save
          end

          if buy_house.save
            buy_house.buy_house_images.create(buy_house_image_url: image_url1)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url2)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url3)
            sleep 2
            buy_house.buy_house_images.create(buy_house_image_url: image_url4)
            sleep 2
          end
          sleep 2
        else
          next

        end
      end
    end 
  end

  def self.chiba
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    #  広島と同じやつ
    charset = nil
    (1..20).each_with_index do |num|
      unless num == 1
        url = "https://bousou.net/search-bukken/all/page/#{num}"
      else
        url = "https://bousou.net/search-bukken/all/"
      end
      link_doc = Nokogiri::HTML(open(url))
      link_doc.xpath('//*[@id="main"]/div[2]/article').each do |node|
        if node.xpath('h3/a').attribute('href').present?
          link = node.xpath('h3/a').attribute('href').value
        else
          next
        end
        doc = Nokogiri::HTML(open(link))
        name = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[4]/td').inner_text.gsub(/\r\n|\r|\n|\s|\t/, "")
        price = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[3]/td').inner_text.gsub(/[万円].*/, "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[^0-9]/,"")
        address = name
        prefecture_id = 12
        access = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[5]/td').inner_text
        madori = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[2]/td').inner_text
        land_area = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[6]/td').inner_text.gsub(/\r\n|\r|\n|\s|\t/, "").gsub(/[㎡].+/, "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub("宅地：", "").gsub("宅地", "").gsub(/\（.*?\）/,"").gsub(/\(.*?\)/,"").gsub("実測：", "").gsub("公簿：", "")  # 「かな」と「英」のカッコをどちらにも対応
        if doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[7]/td').inner_text.include?("母")
          house_area = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[7]/td').inner_text.slice(/[母家：].+/).gsub(/[㎡].+/, "").gsub("母屋：", "").gsub("母家：", "")
        else
          house_area = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[7]/td').inner_text.gsub(/\r\n|\r|\n|\s|\t/, "").gsub(/[㎡].+/, "").gsub("居宅：", "").gsub("延べ", "").gsub("※", "")
        end  
        if doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[8]/td').inner_text[/（(.*?)）/, 1].present?
          built_date = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[8]/td').inner_text[/（(.*?)）/, 1].gsub("年", "") + "-01-01 00:00"
        else
          built_date = nil
        end
        notes = doc.xpath('//*[@id="main"]/article/div[1]/section[1]/section/table/tr[position() > 8]').inner_text.gsub(" ", "")
        recommendation = "great"
        source = link
        image_url1 = doc.xpath('/html/body/div[3]/div[2]/main/article/div[1]/section[1]/div[1]/figure/img')&.attribute('src')&.value
        # トップの家の外装の写真
        image_url2 = doc.xpath('/html/body/div[3]/div[2]/main/article/div[1]/section[2]/div/div/dl[4]/dt/a').attribute('href').value
        image_url3 = doc.xpath('/html/body/div[3]/div[2]/main/article/div[1]/section[2]/div/div/dl[5]/dt/a').attribute('href').value
        # image2,3に関しては後に外装が写ってるものに変更が必要
        if doc.xpath('/html/body/div[3]/div[2]/main/article/div[1]/section[1]/div[2]/section[2]/div/a').attribute('href').present?
          image_url4 = doc.xpath('/html/body/div[3]/div[2]/main/article/div[1]/section[1]/div[2]/section[2]/div/a').attribute('href').value
          # 間取図
        else
          image_url4 = doc.xpath('/html/body/div[3]/div[2]/main/article/div[1]/section[2]/div/div/dl[2]/dt/a').attribute('href').value

        end
        buy_house = BuyHouse.where(name: name).where(price: price).where(access: access).first
        if buy_house.present?
          next
        else
          buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, built_date: built_date, notes: notes, recommendation: recommendation, source: source)
          buy_house.save
        end
        if buy_house.save
          buy_house.buy_house_images.create(buy_house_image_url: image_url1)
          sleep 2
          buy_house.buy_house_images.create(buy_house_image_url: image_url2)
          sleep 2
          buy_house.buy_house_images.create(buy_house_image_url: image_url3)
          sleep 2
          buy_house.buy_house_images.create(buy_house_image_url: image_url4)
          sleep 2
        end
      end
    end 
  end


  def self.akita
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil

    (1..3).each do |num|
      unless num == 1
        link = "https://www.homes.co.jp/akiyabank/tohoku/akita?category%5B0%5D=101&page=#{num}" 
      else 
        link = "https://www.homes.co.jp/akiyabank/tohoku/akita/?category%5B%5D=101#selected_list"
      end

      link_doc = Nokogiri::HTML(open(link))
      link_doc.xpath('//*[@id="searchResultList"]/div[1]/div').each do |node|
        url = node.xpath('a').attribute('href').value
        doc = Nokogiri::HTML(open(url))
        name = doc.xpath("//th[contains(., '所在地')]/following-sibling::td[1]").inner_text.gsub(/\r\n|\r|\n|\s|\t/, "").gsub("秋田県", "")
        
        if doc.xpath("//th[contains(., '価格')]/following-sibling::td[1]").inner_text.include?("応相談")
          price = nil
        else
          price = doc.xpath("//th[contains(., '価格')]/following-sibling::td[1]").inner_text.gsub(/[^0-9]/,"").to_i/10000
        end
        address = name
        prefecture_id = 5
        access = doc.xpath("//th[contains(., '交通')]/following-sibling::td[1]").inner_text.gsub(/\r\n|\r|\n|\s|\t/, "")
        madori = doc.xpath("//th[contains(., '間取り')]/following-sibling::td[1]").inner_text.gsub(/\r\n|\r|\n|\s|\t/, "")
        land_area = doc.xpath("//th[contains(., '土地面積')]/following-sibling::td[1]").inner_text.gsub(/\r\n|\r|\n|\s|\t/, "").gsub(/[㎡].+/, "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(",", "")
        house_area = doc.xpath("//th[contains(., '建物面積')]/following-sibling::td[1]").inner_text.gsub(/\r\n|\r|\n|\s|\t/, "").gsub(/[㎡].+/, "").tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(",", "")
        unless doc.xpath("//th[contains(., '築年月')]/following-sibling::td[1]").inner_text&.gsub(" ", "")&.gsub(/\n/, "")&.gsub(/月.*/, "").slice(/(.*)(?=年)/) == nil
          built_date = doc.xpath("//th[contains(., '築年月')]/following-sibling::td[1]").inner_text&.gsub(" ", "")&.gsub(/\n/, "")&.gsub(/月.*/, "").slice(/(.*)(?=年)/).tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z') + "-" + doc.xpath("//tr[contains(.,'築年')]/td[contains(., '年')]").inner_text&.gsub(" ", "")&.gsub(/\n/, "")&.gsub(/月.*/, "").slice(/年.*/)&.gsub("年", "")&.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z') + "-01" + " 00:00"
        else
          built_date = nil
        end
        notes = doc.xpath('//div[contains(@class, "mod-bukkenAround")]/div/table/tbody').inner_text + doc.xpath('//div[contains(@class, "mod-bukkenSetsubi")]').inner_text + doc.xpath('//div[contains(@class, "mod-bukkenGaiyou")]/div/table/tbody').inner_text
        recommendation = "great"
        source = url
        image_url1 = doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[1]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        image_url2 = doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[2]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        image_url3 = doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[3]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        image_url4 = doc.xpath('//div[contains(@class, "thumb_bukken_images")]/ul/li[4]/div')&.attribute('style')&.value&.gsub(/(.*)(?=https)/, "")&.gsub(");", "")&.gsub("90x90", "562x418")
        
        buy_house = BuyHouse.where(name: name).where(price: price).where(access: access).where(built_date: built_date).first
        if  buy_house.present?
          next
        else
          buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, built_date: built_date, notes: notes, recommendation: recommendation, source: source)
          buy_house.save
        end
        if buy_house.save
          if image_url1&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url1)
            sleep 2
          end
          if image_url2&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url2)
            sleep 2
          end
          if image_url3&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url3)
            sleep 2
          end
          if image_url4&.include?("https")
            buy_house.buy_house_images.create(buy_house_image_url: image_url4)
            sleep 2
          end
        end
        sleep 2
      end
    end    
  end



  def self.miyazaki
    user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
    charset = nil
    link = "https://iju.pref.miyazaki.lg.jp/housebank/"
    link_doc = Nokogiri::HTML(open(link))

    url_array = []
    
    link_doc.xpath('//*[@id="contents"]/div[2]/section/div[1]/div[2]/div[2]/div[3]/ul/li').each do |node| 
      if node.xpath('a').attribute('href').present?  
        if node.xpath('a').inner_text.to_i > 29
          akiya_url = "https://iju.pref.miyazaki.lg.jp" + node.xpath('a').attribute('href').value
          akiya_doc = Nokogiri::HTML(open(akiya_url))
          last_num =  akiya_doc.xpath('//*[@id="contents"]/section/div/div[1]/div/div[6]/div/span[8]').xpath('a').attribute('href').value[/\d+/].to_i 

          (1..last_num).each do |num|
            if num == 1
              url = "https://iju.pref.miyazaki.lg.jp" + node.xpath('a').attribute('href').value
              url_array << url
            else
              url = "https://iju.pref.miyazaki.lg.jp" + node.xpath('a').attribute('href').value + "/page/#{num}"
              url_array << url
            end
          end
        elsif node.xpath('a').inner_text.to_i < 30 && node.xpath('a').inner_text.to_i > 5
          akiya_url = "https://iju.pref.miyazaki.lg.jp" + node.xpath('a').attribute('href').value
          url_array << akiya_url
          akiya_doc = Nokogiri::HTML(open(akiya_url))
          akiya_doc.xpath('//*[@id="contents"]/section/div/div[1]/div/div[6]/div/span').each do |page|
            if page.xpath('a').present?
              if page.xpath('a').inner_text.include?("次のページ")
                next
              else
                url = "https://iju.pref.miyazaki.lg.jp" + page.xpath('a').attribute('href').value
                url_array << url
              end
            else
              next
            end
          end
        else  
          url = "https://iju.pref.miyazaki.lg.jp" + node.xpath('a').attribute('href').value
          url_array << url
        end
      else
        next
      end
#arrayに入れて、array.each do にする
#今の段階ではurlを複数保存してbank_docに行ってる
    end

    url_array.each do |url|
      bank_doc = Nokogiri::HTML(open(url))
      bank_doc.xpath('//*[@id="contents"]/section/div/div[1]/div/div').each do |span|
        if span.inner_text.include?("売り物件")

          if span.xpath('div/a').attribute('href').present?
            bank_url = "https://iju.pref.miyazaki.lg.jp" + span.xpath('div/a').attribute('href').value.gsub("宮崎市", "%E5%AE%AE%E5%B4%8E%E5%B8%82").gsub("延岡市", "%E5%BB%B6%E5%B2%A1%E5%B8%82").gsub("高千穂町", "%E9%AB%98%E5%8D%83%E7%A9%82%E7%94%BA").gsub("日之影町", "%E6%97%A5%E4%B9%8B%E5%BD%B1%E7%94%BA").gsub("五ヶ瀬町", "%E4%BA%94%E3%83%B6%E7%80%AC%E7%94%BA").gsub("美郷町", "%E7%BE%8E%E9%83%B7%E7%94%BA").gsub("串間市", "%E4%B8%B2%E9%96%93%E5%B8%82").gsub("日向市", "%E6%97%A5%E5%90%91%E5%B8%82").gsub("日南市", "%E6%97%A5%E5%8D%97%E5%B8%82").gsub("木城町", "%E6%9C%A8%E5%9F%8E%E7%94%BA").gsub("西米良村", "%E8%A5%BF%E7%B1%B3%E8%89%AF%E6%9D%91").gsub("西都市", "%E8%A5%BF%E9%83%BD%E5%B8%82").gsub("小林市", "%E5%B0%8F%E6%9E%97%E5%B8%82").gsub("国富町", "%E5%9B%BD%E5%AF%8C%E7%94%BA").gsub("都城市", "%E9%83%BD%E5%9F%8E%E5%B8%82").gsub("えびの市", "%E3%81%88%E3%81%B3%E3%81%AE%E5%B8%82").gsub("三股町", "%E4%B8%89%E8%82%A1%E7%94%BA").gsub("高原町", "%E9%AB%98%E5%8E%9F%E7%94%BA")
            #urlに漢字が含んだ状態では、Encoding::ConverterNotFoundError (code converter not found (UTF-8 to https://iju.pref.miyazaki.lg.jp/housebank/housebank-16134/?histry=延岡市))      となるので、ゴリゴリで変換した
            doc = Nokogiri::HTML(open(bank_url))
            if span.xpath('div/a').attribute('href').value.include?("宮崎市")
              name = "宮崎市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("延岡市")
              name = "延岡市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("高千穂町")
              name = "高千穂町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("日之影町")
              name = "日之影町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("五ヶ瀬町")
              name = "五ヶ瀬町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("美郷町")
              name = "美郷町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("串間市")
              name = "串間市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("日向市")
              name = "日向市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("日南市")
              name = "日南市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("木城町")
              name = "木城町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("西米良村")
              name = "西米良村" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("西都市")
              name = "西都市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("小林市")
              name = "小林市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("国富町")
              name = "国富町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("都城市")
              name = "都城市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("えびの市")
              name = "えびの市" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("三股町")
              name = "三股町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            elsif span.xpath('div/a').attribute('href').value.include?("高原町")
              name = "高原町" + doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[1]/td[1]').inner_text
            else
              name = nil
            end

            if doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[5]/td[2]').inner_text.include?("⇒") or doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[5]/td[2]').inner_text.include?("～")
              price = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[5]/td[2]').inner_text.slice(/[万円].+/).tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[^0-9]/,"")
            elsif doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[5]/td[2]').inner_text.include?("談")
              price = nil
            else
              price = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[5]/td[2]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[^0-9]/,"")
            end
            access = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[9]/td[1]').inner_text
            address = name
            madori = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[2]').inner_text
            if doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[2]/td[1]').inner_text.include?("m²") or doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[2]/td[1]').inner_text.include?("㎡")
              house_area = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[2]/td[1]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[m²].+/, "").gsub("㎡", "")
            else
              house_area = nil
            end            
            land_area = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[9]/td[2]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[m²].+/, "").gsub("," , "")
            recommendation = "great"
            source = bank_url
            prefecture_id = 45
            if doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.include?("昭和")
              built_date = (doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/].to_i + 1925).to_s + "-01-01 00:00"
            elsif doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.include?("平成")
              built_date = (doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')[/\d+/].to_i + 1988).to_s + "-01-01 00:00"
            elsif doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.include?("年")
              if doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[年].+/, "").gsub("築", "").to_i > 1800
                built_date = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[10]/td[1]').inner_text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/[年].+/, "") + "-01-01 00:00"
              end
            else 
              built_date = nil
            end
            notes = doc.xpath('//*[@id="contents"]/section/div[2]/div[1]/div[3]/div[2]/table/tbody/tr[position() > 1]').inner_text
            buy_house = BuyHouse.where(name: name).where(price: price).where(access: access).where(built_date: built_date).where(source: source).first
            if  buy_house.present?
              next
            else
              buy_house = BuyHouse.new(name: name, prefecture_id: prefecture_id, price: price, address: address, access: access, madori: madori, land_area: land_area, house_area: house_area, built_date: built_date, notes: notes, recommendation: recommendation, source: source)
              buy_house.save
            end
            if doc.xpath('//img[not(contains(@src, "themes"))]/@src').present?
              doc.xpath('//img[not(contains(@src, "themes"))]/@src').each_with_index do |img, i|
                if doc.xpath('//img[contains(@src, "uploads")]/@src').present?
                  if i < 4 && img.present? 
                    image_url = "https://iju.pref.miyazaki.lg.jp" + img
                    buy_house.buy_house_images.create(buy_house_image_url: image_url)
                    sleep 2
                  end
                end
              end
            end
          else
            next
          end
        else
          next
        end
      end
    end
  end
end