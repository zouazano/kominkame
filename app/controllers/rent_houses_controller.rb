class RentHousesController < ApplicationController
  def show
    @rent_house = RentHouse.find(params[:id])
    rent_house_id = @rent_house.id
  end
end
