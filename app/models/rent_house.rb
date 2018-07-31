class RentHouse < ApplicationRecord
  has_many :house_images, dependent: :destroy
  has_many :inquiries
  accepts_nested_attributes_for :inquiries

  enum recommendation: { bad: 0, normal: 1, good: 2, great: 3 }
  enum prefecture_id: { hokkaido: 1, aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7, tokyo: 8, kanagawa: 9, saitama: 10, chiba: 11, ibaraki: 12, gunnma: 13, tochigi: 14, yamanashi: 15, nigata: 16, nagano: 17, toyama: 18, ishikawa: 19, fukui: 20, aichi: 21, gifu: 22, shizuoka: 23, mie: 24, osaka: 25, hyogo: 26, kyoto: 27, shiga: 28, nara: 29, wakayama: 30, tokushima: 31, kagawa: 32, ehime: 33, kochi: 34, tottori: 35, shimane: 36, okayama: 37, hiroshima: 38, yamaguchi: 39, fukuoka: 40, saga: 41, nagasaki: 42, kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46, okinawa: 47 }
 	
end
