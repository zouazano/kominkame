class RentHouseImage < ApplicationRecord
	belongs_to :rent_house

	dragonfly_accessor :rent_house_image
end
