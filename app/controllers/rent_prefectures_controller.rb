# frozen_string_literal: true

class RentPrefecturesController < ApplicationController
  def index; end

  def show
    @rent_prefecture = RentPrefecture.find(params[:id])
  end
end
