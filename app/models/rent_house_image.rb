class RentHouseImage < ApplicationRecord
	belongs_to :rent_house

	mount_uploader :image, ImageUploader
end
