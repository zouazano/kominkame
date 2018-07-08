# frozen_string_literal: true

class BuyPrefecturesController < ApplicationController
  def index; end

  def show
    @buy_prefecture = BuyPrefecture.find(params[:id])
  end
end
