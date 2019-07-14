require 'open-uri'
require 'nokogiri'
require 'csv'


class LinkChecker
  def self.check
    BuyHouse.all.each do |buy_house|
      unless buy_house.source.nil?
        url = buy_house.source.gsub(/(.*)(?=http)/,"")
        encoded_url = URI.encode(url)
        
        unless Net::HTTP.get_response(URI.parse(encoded_url)).code == "404" or Net::HTTP.get_response(URI.parse(encoded_url)).code == "403"
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