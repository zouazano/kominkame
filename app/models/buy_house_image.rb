class BuyHouseImage < ApplicationRecord
	belongs_to :buy_house

	dragonfly_accessor :buy_house_image
end