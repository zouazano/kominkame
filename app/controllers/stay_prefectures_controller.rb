# frozen_string_literal: true

class StayPrefecturesController < ApplicationController
  def index
  	set_meta_tags noindex: true
  end

  def show
  	set_meta_tags noindex: true
    @prefecture = Prefecture.find(params[:id])
  end
end
