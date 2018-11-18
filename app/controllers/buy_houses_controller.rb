class BuyHousesController < ApplicationController
  def show
    @buy_house = BuyHouse.find(params[:id])
    buy_house_id = @buy_house.id
	  add_breadcrumb "ホーム", root_path
	  add_breadcrumb "古民家を買う", buy_index_path
    add_breadcrumb "#{@buy_house.prefecture.name}の古民家物件", buy_prefecture_path(@buy_house.prefecture.id)
    add_breadcrumb "#{@buy_house.name}の古民家物件"
  end
end