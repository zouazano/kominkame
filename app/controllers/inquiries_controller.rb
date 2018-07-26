# frozen_string_literal: true

class InquiriesController < ApplicationController
  def show

  end

  def new
    @house = House.find(params[:house_id])
    @inquiry = @house.inquiries.new
  end

  def create
    @house = House.find(params[:house_id])
    @inquiry = @house.inquiries.create(inquiry_params)
    if @inquiry.save
      redirect_to house_path(@house)
      flash = '予約を送信しました。メールをご確認ください。'
    else
      render 'new'
    end
  end

  def confrim

  end


  private

    def inquiry_params
      params.require(:inquiry).permit(:house_id, :address, :name, :email, :phonenumber, :demand, :message)
    end


end
