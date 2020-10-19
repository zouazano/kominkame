class BuyHousesController < ApplicationController
  def show
  	set_meta_tags noindex: true
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

    @buy_house = BuyHouse.find(params[:id])
    buy_house_id = @buy_house.id
	  add_breadcrumb "ホーム", root_path
	  add_breadcrumb "古民家を買う", buy_index_path
    add_breadcrumb "#{@buy_house.prefecture.name}の古民家物件", buy_prefecture_path(@buy_house.prefecture.id)
    add_breadcrumb "#{@buy_house.name}の古民家物件"
  end
end