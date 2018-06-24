class StayPrefecturesController < ApplicationController
  def index
  end

  def show
  	@stay_prefecture = StayPrefecture.find(params[:id])
  end
end
