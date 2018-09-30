# frozen_string_literal: true

class TopController < ApplicationController

  def index
    @buy_houses = BuyHouse.where(recommendation: 3).page(params[:page])
  end
end