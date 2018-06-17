class HousesController < ApplicationController
	def index
		@houses = House.all
	end

	def show
		@house = House.find(params[:id])
	end

	def new
		@house = House.new
	end

	def create
		@house = House.new(house_params)
		@house.save
	end
end


private
	def house_params
		params[:house].permit(:name, :strong_point, :prefecture_id, :zip_code, :address, :access, :hours, :shop_id, :price, :image, :type, :age, :madori, :land_area, :house_area, :built_time)
	end