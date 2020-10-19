# frozen_string_literal: true

class RentController < ApplicationController
  def index
  	set_meta_tags noindex: true
  end

  def show
  	set_meta_tags noindex: true
  end
end
