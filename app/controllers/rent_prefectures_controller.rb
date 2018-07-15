# frozen_string_literal: true

class RentPrefecturesController < ApplicationController
  def index; end

  def show
    @prefecture = Prefecture.find(params[:id])
  end
end