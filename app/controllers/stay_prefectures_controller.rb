# frozen_string_literal: true

class StayPrefecturesController < ApplicationController
  def index
  	set_meta_tags noindex: true, nofollow: true
  end

  def show
  	set_meta_tags noindex: true, nofollow: true
    @prefecture = Prefecture.find(params[:id])
  end
end
