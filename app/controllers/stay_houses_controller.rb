class StayHousesController < ApplicationController
  def show
    @stay_house = StayHouse.find(params[:id])
    stay_house_id = @stay_house.id
  end
end
