# frozen_string_literal: true

class TopController < ApplicationController

  def index
    if params[:page].present?
      set_meta_tags noindex: true, nofollow: true
    end
    @buy_houses = BuyHouse.where(recommendation: 3).page(params[:page])
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
end