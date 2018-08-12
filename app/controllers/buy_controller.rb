# frozen_string_literal: true

class BuyController < ApplicationController
  def index
  	@buy_houses = BuyHouse.where(recommendation: 3).page(params[:page])
  end

  def show
    @house = House.find(params[:id])
  end
end
