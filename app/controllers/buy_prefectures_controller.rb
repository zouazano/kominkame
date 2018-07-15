# frozen_string_literal: true

class BuyPrefecturesController < ApplicationController
  def index; end

  def show
    @prefecture = Prefecture.find(params[:id])
  end
end
