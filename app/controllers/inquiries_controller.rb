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
	    redirect_to @inquiry, notice: "ユーザ登録しました。"
	  else
	    render 'new'
  end

  private
  
	  def inquiry_params
	    params[:inquiry].permit(:house_id, :name, :email, :phonenumber, :demand, :message)
	  end

end

  def confrim
  end


end
