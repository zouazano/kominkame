# frozen_string_literal: true

class StayController < ApplicationController
  def index
  	set_meta_tags noindex: true, nofollow: true
  end

  def show
  	set_meta_tags noindex: true, nofollow: true
  end
end
