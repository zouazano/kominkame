# frozen_string_literal: true

class BuyPrefecturesController < ApplicationController
	add_breadcrumb "ホーム", :root_path
	add_breadcrumb "古民家を買う", :buy_index_path

  def index
  	add_breadcrumb "地域から古民家を探す"
  end

  def show
    @prefecture = Prefecture.find(params[:id])
    @buy_houses = BuyHouse.where(prefecture_id: @prefecture.id).page(params[:page])

    add_breadcrumb "#{@prefecture.name}の古民家物件", buy_prefecture_path(@prefecture.id)
  end
end