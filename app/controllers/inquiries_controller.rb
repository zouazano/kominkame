# frozen_string_literal: true

class InquiriesController < ApplicationController
  def show

  end

  def new
    @house = House.find(params[:house_id])
    @inquiry = Inquiry.new
  end

  def create
    @house = House.find(params[:house_id])
    @inquiry = Inquiry.create(inquiry_params)
    if @inquiry.save
      redirect_to house_path(@house_id)
    else
      redirect_to top_index_path
    end
  end


  def confrim

  end


  private

    def inquiry_params
      params.require(:inquiry).permit(:house_id, :address, :name, :email, :phonenumber, :demand, :message)
    end


end
