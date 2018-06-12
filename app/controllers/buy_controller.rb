class BuyController < ApplicationController
  def index
  end

  def show
  	@house = House.find(params[:id])
  end
end
