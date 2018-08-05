# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

CSV.foreach("db/seeds/rent_house.csv", headers: true) do |row|
  attributes = row.to_h.slice("name", "strong_point", "prefecture_id", "rent", "maintenance_fee", "deposit", "gratuity_fee", "zip_code", "address", "access", "hours", "age", "madori", "land_area", "house_area", "built_time", "stayable", "rentable", "buyable", "recommendation", "shop_id", "source")
  RentHouse.where(name: row["name"]).first_or_create(attributes)
end