# frozen_string_literal: true

class BuyController < ApplicationController
	
  def index
  	@buy_houses = BuyHouse.where(recommendation: 3).page(params[:page])
  	add_breadcrumb "ホーム", root_path
  	add_breadcrumb "古民家を買う"
  end

  def show
    @house = House.find(params[:id])
  end
end
