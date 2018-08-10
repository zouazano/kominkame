require "csv"
require "yaml"

class StayHouseLoader
  def self.load
    CSV.foreach("db/seeds/stay_house.csv", headers: true) do |row|
      attributes = row.to_h.slice("name", "strong_point", "prefecture_id", "price", "zip_code", "address", "access", "hours", "age", "madori", "land_area", "house_area", "built_time", "notes", "recommendation", "shop_id", "source")
      stay_house = StayHouse.where(name: row["name"]).first_or_create(attributes)
      if row["image_url1"].present?
        stay_house.stay_house_images.create(stay_house_image_url: row["image_url1"])
      end
      sleep 2
      if row["image_url2"].present?
        stay_house.stay_house_images.create(stay_house_image_url: row["image_url2"])
      end
      sleep 2
      if row["image_url3"].present?
        stay_house.stay_house_images.create(stay_house_image_url: row["image_url3"])
      end
      sleep 2
      if row["image_url4"].present?
        stay_house.stay_house_images.create(stay_house_image_url: row["image_url4"])
      end
      sleep 2
    end  
  end
end