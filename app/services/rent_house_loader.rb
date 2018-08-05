require "csv"

class RentHouseLoader
  def self.load
    CSV.foreach("db/seeds/rent_house.csv", headers: true) do |row|
      attributes = row.to_h.slice("name", "strong_point", "prefecture_id", "rent", "maintenance_fee", "deposit", "gratuity_fee", "zip_code", "address", "access", "hours", "age", "madori", "land_area", "house_area", "built_time", "stayable", "rentable", "buyable", "recommendation", "shop_id", "source")
      RentHouse.where(name: row["name"]).first_or_create(attributes)
    end  
  end
end