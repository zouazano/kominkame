# frozen_string_literal: true

class BuyPrefecturesController < ApplicationController

  def index
    @q = BuyHouse.all.ransack(params[:q])
    @buy_houses = @q.result(distinct: true).page(params[:page])
    if params[:page].present? || params[:q].present?
      set_meta_tags noindex: true, nofollow: true
    end
    add_breadcrumb "ホーム", root_path
    add_breadcrumb "古民家を買う", buy_index_path
   end

  def show
    @prefecture = Prefecture.find(params[:id])
    @q = BuyHouse.where(prefecture_id: @prefecture.id).ransack(params[:q])
    @buy_houses = @q.result(distinct: true).page(params[:page])

    if params[:page].present? || params[:q].present?
      set_meta_tags noindex: true, nofollow: true
    end
    


    @land_area_p_average = []
    @house_area_p_average = []
    @built_date_p_average = []
    @price_p_average = []
    BuyHouse.where(prefecture_id: @prefecture.id).all.each do |hoge|
      @land_area_p_average << hoge.land_area
      @house_area_p_average << hoge.house_area
      @built_date_p_average << hoge.built_date&.year
      @price_p_average << hoge.price
    end
    @land_area_average = []
    @house_area_average = []
    @built_date_average = []
    @price_average = []
    BuyHouse.all.each do |hoge|
      @land_area_average << hoge.land_area
      @house_area_average << hoge.house_area
      @built_date_average << hoge.built_date&.year
      @price_average << hoge.price
    end

    add_breadcrumb "ホーム", root_path
    add_breadcrumb "古民家を買う", buy_index_path
    add_breadcrumb "#{@prefecture.name}の古民家物件", buy_prefecture_path(@prefecture.id)
  end

  private
  def search_params
    params.require(:q).permit(:name_cont)
  end
end