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

end