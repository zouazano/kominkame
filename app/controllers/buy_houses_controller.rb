class BuyHousesController < ApplicationController
  def show
    @buy_house = BuyHouse.find(params[:id])
    buy_house_id = @buy_house.id
    @prefecture = Prefecture.find(@buy_house.prefecture_id)
  end
end