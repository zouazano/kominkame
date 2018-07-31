class BuyHouseImage < ApplicationRecord
	belongs_to :buy_house

	mount_uploader :image, ImageUploader
end
