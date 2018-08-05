require "csv"
require "yaml"

class RentHouseLoader
  def self.load
    CSV.foreach("db/seeds/rent_house.csv", headers: true) do |row|
      attributes = row.to_h.slice("name", "strong_point", "prefecture_id", "rent", "maintenance_fee", "deposit", "gratuity_fee", "zip_code", "address", "access", "hours", "age", "madori", "land_area", "house_area", "built_time", "stayable", "rentable", "buyable", "recommendation", "shop_id", "source")
      RentHouse.where(name: row["name"]).first_or_create(attributes)
    end  
  end

  def self.yamload
  	rh = YAML.load_file("db/seeds/rent_house.yml")
    rh.each do |rent_house_data|
    	rent_house = RentHouse.find_or_create_by(name: rent_house_data["name"])

    	rent_house_data["image_url"].each do |image_url|
    		rent_house.rent_house_images.create(remote_image_url: image_url)
    	end
    end
  end
end