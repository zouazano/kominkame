# frozen_string_literal: true

class HousesController < ApplicationController
  def index
    set_meta_tags noindex: true, nofollow: true
    @houses = House.all
  end

  def show
    set_meta_tags noindex: true, nofollow: true
    @house = House.find(params[:id])
    house_id = @house.id
  end

  def new
    set_meta_tags noindex: true, nofollow: true
    @house = House.new
  end

  def create
    set_meta_tags noindex: true, nofollow: true
    @house = House.new(house_params)
    @house.save
  end
end

private
def house_params
  params[:house].permit(:name, :strong_point, :prefecture_id, :zip_code, :address, :access, :hours, :shop_id, :price, :image1, :image2, :image3, :image4, :image5, :image6, :type, :age, :madori, :land_area, :house_area, :built_time)
  end
