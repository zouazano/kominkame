class House < ApplicationRecord
	mount_uploader :image, ImageUploader
	dragonfly_accessor :image
end
