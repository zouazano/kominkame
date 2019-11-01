# frozen_string_literal: true

class InquiriesController < ApplicationController
  def show

  end

  def new
    #@house = House.find(params[:house_id])
    @buy_house = BuyHouse.find(params[:buy_house_id])
    @inquiry = @buy_house.inquiries.new
  end

  def create
    #@house = House.find(params[:house_id])
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.with(inquiry: @inquiry).completion_mailer.deliver_now
      redirect_to inquiries_completion_path
    else
      render 'new'
    end
  end

  def completion

  end


  private

    def inquiry_params
      params.require(:inquiry).permit(:buy_house_id, :address, :name, :email, :phonenumber, :demand, :message)
    end


end
