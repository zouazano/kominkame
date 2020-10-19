# frozen_string_literal: true

class BuyController < ApplicationController

  def index
    if params[:page].present? || params[:q].present?
      set_meta_tags noindex: true
    end
    @q = BuyHouse.where(recommendation:3).where(sold:false).ransack(params[:q])
    @buy_houses = @q.result(distinct: true).page(params[:page])
  	add_breadcrumb "ホーム", root_path
  	add_breadcrumb "古民家を買う"
  	@land_area_average = []
  	@house_area_average = []
  	@built_date_average = []
  	@price_average = []
  	BuyHouse.where(recommendation:3).where(sold:false).each do |hoge|
  		@land_area_average << hoge.land_area
  		@house_area_average << hoge.house_area
  		@built_date_average << hoge.built_date&.year
  		@price_average << hoge.price
  	end
  end

  def show
    @house = House.find(params[:id])
  end
  private
  def search_params
    params.require(:q).permit(:name_cont)
  end
end
