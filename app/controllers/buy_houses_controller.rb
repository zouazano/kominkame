class BuyHousesController < ApplicationController
  def show
    @buy_house = BuyHouse.find(params[:id])
    buy_house_id = @buy_house.id
  end
end