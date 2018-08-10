class StayHouseImage < ApplicationRecord
	belongs_to :stay_house

  dragonfly_accessor :stay_house_image
end
