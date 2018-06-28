class HouseImage < ApplicationRecord
	belongs_to :house

	mount_uploader :image, ImageUploader
end
