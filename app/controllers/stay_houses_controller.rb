class StayHousesController < ApplicationController
  def show
  	set_meta_tags noindex: true, nofollow: true
    @stay_house = StayHouse.find(params[:id])
    stay_house_id = @stay_house.id
  end
end
