class House < ApplicationRecord

	mount_uploader :image1, ImageUploader
	mount_uploader :image2, ImageUploader
	mount_uploader :image3, ImageUploader
	mount_uploader :image4, ImageUploader
	mount_uploader :image5, ImageUploader
	mount_uploader :image6, ImageUploader
	enum dealtype: { buy: 0, rent: 1, stay: 2 }
	enum prefecture_id: { hokkaido: 1, aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7, tokyo: 8, kanagawa: 9, saitama: 10, chiba: 11, ibaraki: 12, gunnma: 13, tochigi: 14, yamanashi: 15, nigata: 16, nagano: 17, toyama: 18, ishikawa: 19, fukui: 20, aichi: 21, gifu: 22, shizuoka: 23, mie: 24, osaka: 25, hyogo: 26, kyoto: 27, shiga: 28, nara: 29, wakayama: 30, tokushima: 31, kagawa: 32, ehime: 33, kochi: 34, tottori: 35, shimane: 36, okayama: 37, hiroshima: 38, yamaguchi: 39, fukuoka: 40, saga: 41, nagasaki: 42, kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46, okinawa: 47 }
	enum rent_prefecture_id: { hokkaido_rent: 1, aomori_rent: 2, iwate_rent: 3, miyagi_rent: 4, akita_rent: 5, yamagata_rent: 6, fukushima_rent: 7, tokyo_rent: 8, kanagawa_rent: 9, saitama_rent: 10, chiba_rent: 11, ibaraki_rent: 12, gunnma_rent: 13, tochigi_rent: 14, yamanashi_rent: 15, nigata_rent: 16, nagano_rent: 17, toyama_rent: 18, ishikawa_rent: 19, fukui_rent: 20, aichi_rent: 21, gifu_rent: 22, shizuoka_rent: 23, mie_rent: 24, osaka_rent: 25, hyogo_rent: 26, kyoto_rent: 27, shiga_rent: 28, nara_rent: 29, wakayama_rent: 30, tokushima_rent: 31, kagawa_rent: 32, ehime_rent: 33, kochi_rent: 34, tottori_rent: 35, shimane_rent: 36, okayama_rent: 37, hiroshima_rent: 38, yamaguchi_rent: 39, fukuoka_rent: 40, saga_rent: 41, nagasaki_rent: 42, kumamoto_rent: 43, oita_rent: 44, miyazaki_rent: 45, kagoshima_rent: 46, okinawa_rent: 47 }

end
