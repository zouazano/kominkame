class Shop < ApplicationRecord
	has_many :houses
	has_many :inquiries
end
