require 'open-uri'
require 'nokogiri'
require 'csv'


class AkiyaBankCrawler
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

        buy_house = BuyHouse.where(name: name).where(price: price).first
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