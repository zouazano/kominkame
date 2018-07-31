class StayHouseImage < ApplicationRecord
	belongs_to :stay_house

	mount_uploader :image, ImageUploader
end
