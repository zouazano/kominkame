class RentHousesController < ApplicationController
  def show
  	set_meta_tags noindex: true
    @rent_house = RentHouse.find(params[:id])
    rent_house_id = @rent_house.id
  end
end
