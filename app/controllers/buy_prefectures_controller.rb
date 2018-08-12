# frozen_string_literal: true

class BuyPrefecturesController < ApplicationController
  def index
  end

  def show
    @prefecture = Prefecture.find(params[:id])
    @buy_houses = BuyHouse.where(prefecture_id: @prefecture.id).page(params[:page])
  end
end
