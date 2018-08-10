require "csv"
require "yaml"

class RentHouseLoader
  def self.load
    CSV.foreach("db/seeds/rent_house.csv", headers: true) do |row|
      attributes = row.to_h.slice("name", "strong_point", "prefecture_id", "rent", "maintenance_fee", "deposit", "gratuity_fee", "zip_code", "address", "access", "hours", "age", "madori", "land_area", "house_area", "built_time", "recommendation", "shop_id", "source")
      rent_house = RentHouse.where(name: row["name"]).first_or_create(attributes)
      if row["image_url1"].present?
        rent_house.rent_house_images.create(rent_house_image_url: row["image_url1"])
      end
      sleep 2
      if row["image_url2"].present?
        rent_house.rent_house_images.create(rent_house_image_url: row["image_url2"])
      end
      sleep 2
      if row["image_url3"].present?
        rent_house.rent_house_images.create(rent_house_image_url: row["image_url3"])
      end
      sleep 2
      if row["image_url4"].present?
        rent_house.rent_house_images.create(rent_house_image_url: row["image_url4"])
      end
      sleep 2
    end  
  end

  def self.yamload
    rh = YAML.load_file("db/seeds/rent_house.yml")
    rh.each do |rent_house_data|
      attributes = rent_house_data
      rent_house = RentHouse.where(name: rent_house_data["name"]).first_or_create(attributes)

      rent_house_data["image_url"].each do |image_url|
        rent_house.rent_house_images.create(remote_image_url: image_url)
        
        sleep 2
      end
    end
  end
end