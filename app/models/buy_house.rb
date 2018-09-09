class BuyHouse < ApplicationRecord
  has_many :buy_house_images, dependent: :destroy
 

  enum recommendation: { bad: 0, normal: 1, good: 2, great: 3 }
  belongs_to :prefecture
 
end
