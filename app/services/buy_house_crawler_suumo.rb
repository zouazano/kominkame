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

    kominka = ["https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189710882.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz190346506.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189767084.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188893403.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz187828467.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz186036126.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188930583.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190314651.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190634408.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz188363267.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz188802794.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz189230429.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz188408814.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189908332.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz181089682.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz185003206.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz191008499.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz166218024.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz191022998.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz186190405.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz187102964.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz190799868.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz184447471.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz187095267.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz184466169.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz189407066.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190689497.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190410142.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190703347.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190139384.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190980116.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz191002660.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz187705909.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190552718.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz186894998.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190828736.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190606084.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz188611325.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190267874.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz187748528.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189767084.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190682327.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190560053.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz189937253.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190934246.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1010z2bsz1021z2ncz189432747.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz189465650.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190125904.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz189694961.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190769272.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz190671170.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190930724.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190957624.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz188347043.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz183846917.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz189705646.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190938777.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz187178412.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz187685216.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz187526875.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188661832.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190797279.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189153010.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189528349.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz191023495.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz187948583.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz188816318.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190878172.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190132089.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188712304.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190428958.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190649586.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190918637.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188695237.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz186815490.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190952159.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190232619.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190969919.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190965337.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz189937175.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz184698428.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz185285021.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz190731276.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz191016042.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190473982.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190030113.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188094689.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190610745.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz166522041.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz189464160.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz188707286.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz189535437.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz186343853.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190870169.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190678275.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz187653241.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190400027.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz189013815.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190311874.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190929524.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz187899383.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190936578.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz184917173.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190155972.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189187007.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz187355047.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz188433938.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188314920.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz190595807.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190804904.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190930964.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1010z2bsz1021z2ncz190785767.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189775029.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190991880.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189424078.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190782627.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190551255.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190312479.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz188858571.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz189952843.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz187890664.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz189205618.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190409410.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz183122342.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190537731.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz189055862.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190713092.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190834599.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz184999339.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190664224.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190681231.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz189580381.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz191013068.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190719814.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz189222091.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189283371.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190800424.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz190166165.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190680625.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz190647637.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz182406656.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz191015676.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz188868996.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz191022747.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1010z2bsz1021z2ncz187355748.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1020z2bsz1021z2ncz190283205.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz189656259.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190858450.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190266554.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190746301.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz189958202.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz190279585.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz185598901.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190558025.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz185867682.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190423197.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190932648.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190206996.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz187531964.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188650740.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz189748343.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189977254.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190074616.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190747140.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190669383.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1010z2bsz1021z2ncz189831444.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190005810.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1070z2bsz1021z2ncz188162416.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190789397.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189278210.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190519829.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188461023.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190412081.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190767698.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190829532.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz190005405.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1080z2bsz1021z2ncz188305976.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz181542685.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188697764.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190708362.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz189959410.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190228959.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz185911251.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190969736.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190695624.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190822097.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190760389.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190615455.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190810502.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz187762215.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188044786.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1090z2bsz1021z2ncz190979582.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz188732562.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190016099.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188904882.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1060z2bsz1021z2ncz188721374.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz191001318.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz188728277.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz186855440.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz187695704.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1040z2bsz1021z2ncz190065376.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1030z2bsz1021z2ncz190946971.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz190959445.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz188655342.html?suit=nsuusbsp20121129001", "https://suumo.jp/chukoikkodate/__JJ_JJ010FJ100_arz1050z2bsz1021z2ncz189381863.html?suit=nsuusbsp20121129001"]

    CSV.open("buy_house_suumo.csv", "w") do |csv|
      header = ['name', 'address', 'access', 'madori', 'land_area', 'house_area', 'built_date', 'strong_point', 'prefecture_name', 'price', 'zip_code', 'hours', 'age', 'built_time', 'recommendation', 'notes', 'shop_id', 'source', 'image_url1', 'image_url2', 'image_url3', 'image_url4']
      csv << header
      kominka.first(3).each do |i| 
        url = "#{i}"
        user_agent = "User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:28.0) Gecko/20100101 Firefox/28.0"
        charset = nil


        html = open(url) do |f|
          charset = f.charset
          f.read
        end

        buy_house_info = []

        doc = Nokogiri::HTML.parse(html, nil, charset)

        
        (4..5).each do |n|
          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/th[1]").inner_text == '住所'
            name = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[1]/p[1]").inner_text
            if name.slice(0, 3) == '鹿児島' or name.slice(0, 3) == '和歌山'
              name.slice!(0, 4)
            else
              name.slice!(0, 3)
            end

            address = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[1]/p[1]").inner_text
            buy_house_info.push(name, address)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/th[2]").inner_text == '交通'
            access = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[5]/td[2]/div").inner_text
            buy_house_info.push(access)
          else
          end
          
          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[1]/th[2]/div[1]").inner_text == '間取り'
            madori = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[1]/td[2]/p").inner_text.sub(/\r.*/m, "")
            buy_house_info.push(madori)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/th[1]/div[1]").inner_text == '土地面積'
            land_area = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/td[1]/text()[1]").inner_text.gsub(/\m.*/m, "")
            land_area.slice!(0, 9)
            buy_house_info.push(land_area)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/th[2]/div[1]").inner_text == '建物面積'
            house_area = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[3]/td[2]/text()").inner_text.gsub(/\m.*/m, "")
            house_area.slice!(0, 9)
            buy_house_info.push(house_area)
          else
          end

          if doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/th[2]/div[1]").inner_text == '完成時期（築年月）'
            built_date = doc.xpath("//*[@id='mainContents']/div[#{n}]/div[1]/table[2]/tbody/tr[4]/td[2]").inner_text.gsub(/年/m, "-").gsub(/月.*/m, "")
            built_date.slice!(0, 9)
            p built_date
            buy_house_info.push(built_date)
          else
          end

        end
        
        strong_point = doc.xpath('//*[@id="mainContents"]/div[2]/h2').inner_text
        prefecture_name = doc.xpath('//*[@id="help_link"]/ul/li[4]/a').inner_text
        price = doc.xpath('//*[@id="topContents"]/div[2]/div[1]/div[2]/p[1]').inner_text.sub(/万.*/m, "")
        zip_code = ''
        hours = ''
        age = ''
        notes = ''
        recommendation = 'great'
        shop_id = ''
        source = url
        image_url1 = doc.xpath('//*[@id="imgG02_001"]').attribute("src").value
        image_url2 = doc.xpath('//*[@id="imgG02_002"]').attribute("src").value
        image_url3 = doc.xpath('//*[@id="imgG02_003"]').attribute("src").value
        image_url4 = doc.xpath('//*[@id="imgG02_004"]').attribute("src").value

        
        buy_house_info.push(strong_point, prefecture_name, price, zip_code, hours, age, notes, recommendation, shop_id, source, image_url1, image_url2, image_url3, image_url4)

        csv << buy_house_info
        sleep 2
      end
    end

  end


  def self.detail_test

    
  end
end





