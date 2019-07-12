# frozen_string_literal: true

class BuyController < ApplicationController
	
  def index
    if params[:page].present?
      set_meta_tags noindex: true, nofollow: true
    end
  	@buy_houses = BuyHouse.where(recommendation: 3).page(params[:page])
  	add_breadcrumb "ホーム", root_path
  	add_breadcrumb "古民家を買う"
  	@land_area_average = []
  	@house_area_average = []
  	@built_date_average = []
  	@price_average = []
  	BuyHouse.all.each do |hoge|
  		@land_area_average << hoge.land_area
  		@house_area_average << hoge.house_area
  		@built_date_average << hoge.built_date&.year
  		@price_average << hoge.price
  	end
  end

  def show
    @house = House.find(params[:id])
  end
end
