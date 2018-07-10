# frozen_string_literal: true

class House < ApplicationRecord
  has_many :house_images, dependent: :destroy
  has_many :inquiries
  accepts_nested_attributes_for :inquiries


  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :image4, ImageUploader
  mount_uploader :image5, ImageUploader
  mount_uploader :image6, ImageUploader
  enum dealtype: { buy: 0, rent: 1, stay: 2 }
  enum recommendation: { bad: 0, normal: 1, good: 2, great: 3 }
  enum prefecture_id: { hokkaido: 1, aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7, tokyo: 8, kanagawa: 9, saitama: 10, chiba: 11, ibaraki: 12, gunnma: 13, tochigi: 14, yamanashi: 15, nigata: 16, nagano: 17, toyama: 18, ishikawa: 19, fukui: 20, aichi: 21, gifu: 22, shizuoka: 23, mie: 24, osaka: 25, hyogo: 26, kyoto: 27, shiga: 28, nara: 29, wakayama: 30, tokushima: 31, kagawa: 32, ehime: 33, kochi: 34, tottori: 35, shimane: 36, okayama: 37, hiroshima: 38, yamaguchi: 39, fukuoka: 40, saga: 41, nagasaki: 42, kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46, okinawa: 47 }
  enum rent_prefecture_id: { hokkaido_rent: 1, aomori_rent: 2, iwate_rent: 3, miyagi_rent: 4, akita_rent: 5, yamagata_rent: 6, fukushima_rent: 7, tokyo_rent: 8, kanagawa_rent: 9, saitama_rent: 10, chiba_rent: 11, ibaraki_rent: 12, gunnma_rent: 13, tochigi_rent: 14, yamanashi_rent: 15, nigata_rent: 16, nagano_rent: 17, toyama_rent: 18, ishikawa_rent: 19, fukui_rent: 20, aichi_rent: 21, gifu_rent: 22, shizuoka_rent: 23, mie_rent: 24, osaka_rent: 25, hyogo_rent: 26, kyoto_rent: 27, shiga_rent: 28, nara_rent: 29, wakayama_rent: 30, tokushima_rent: 31, kagawa_rent: 32, ehime_rent: 33, kochi_rent: 34, tottori_rent: 35, shimane_rent: 36, okayama_rent: 37, hiroshima_rent: 38, yamaguchi_rent: 39, fukuoka_rent: 40, saga_rent: 41, nagasaki_rent: 42, kumamoto_rent: 43, oita_rent: 44, miyazaki_rent: 45, kagoshima_rent: 46, okinawa_rent: 47 }
  enum buy_prefecture_id: { hokkaido_buy: 1, aomori_buy: 2, iwate_buy: 3, miyagi_buy: 4, akita_buy: 5, yamagata_buy: 6, fukushima_buy: 7, tokyo_buy: 8, kanagawa_buy: 9, saitama_buy: 10, chiba_buy: 11, ibaraki_buy: 12, gunnma_buy: 13, tochigi_buy: 14, yamanashi_buy: 15, nigata_buy: 16, nagano_buy: 17, toyama_buy: 18, ishikawa_buy: 19, fukui_buy: 20, aichi_buy: 21, gifu_buy: 22, shizuoka_buy: 23, mie_buy: 24, osaka_buy: 25, hyogo_buy: 26, kyoto_buy: 27, shiga_buy: 28, nara_buy: 29, wakayama_buy: 30, tokushima_buy: 31, kagawa_buy: 32, ehime_buy: 33, kochi_buy: 34, tottori_buy: 35, shimane_buy: 36, okayama_buy: 37, hiroshima_buy: 38, yamaguchi_buy: 39, fukuoka_buy: 40, saga_buy: 41, nagasaki_buy: 42, kumamoto_buy: 43, oita_buy: 44, miyazaki_buy: 45, kagoshima_buy: 46, okinawa_buy: 47 }
  enum stay_prefecture_id: { hokkaido_stay: 1, aomori_stay: 2, iwate_stay: 3, miyagi_stay: 4, akita_stay: 5, yamagata_stay: 6, fukushima_stay: 7, tokyo_stay: 8, kanagawa_stay: 9, saitama_stay: 10, chiba_stay: 11, ibaraki_stay: 12, gunnma_stay: 13, tochigi_stay: 14, yamanashi_stay: 15, nigata_stay: 16, nagano_stay: 17, toyama_stay: 18, ishikawa_stay: 19, fukui_stay: 20, aichi_stay: 21, gifu_stay: 22, shizuoka_stay: 23, mie_stay: 24, osaka_stay: 25, hyogo_stay: 26, kyoto_stay: 27, shiga_stay: 28, nara_stay: 29, wakayama_stay: 30, tokushima_stay: 31, kagawa_stay: 32, ehime_stay: 33, kochi_stay: 34, tottori_stay: 35, shimane_stay: 36, okayama_stay: 37, hiroshima_stay: 38, yamaguchi_stay: 39, fukuoka_stay: 40, saga_stay: 41, nagasaki_stay: 42, kumamoto_stay: 43, oita_stay: 44, miyazaki_stay: 45, kagoshima_stay: 46, okinawa_stay: 47 }

end
