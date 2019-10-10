require 'open-uri'
require 'nokogiri'
require 'csv'


class LinkChecker
  def self.check
    BuyHouse.where(sold:false).each do |buy_house|
      unless buy_house.source.nil?
        url = buy_house.source.gsub(/(.*)(?=http)/,"")
        
        unless Net::HTTP.get_response(URI.parse(url)).code == "404" || Net::HTTP.get_response(URI.parse(url)).code == "403"
          next
        else
          buy_house.update(sold: true)
        end
        sleep 1
      else
        next
      end
    end
  end

  def self.recheck
    BuyHouse.where(sold:true).each do |buy_house|
      unless buy_house.source.nil?
        url = buy_house.source.gsub(/(.*)(?=http)/,"")
        
        unless Net::HTTP.get_response(URI.parse(url)).code == "404" || Net::HTTP.get_response(URI.parse(url)).code == "403"
          buy_house.update(sold: false)
        else
          buy_house.update(sold: true)
        end
        sleep 1
      else
        next
      end
    end
  end

end