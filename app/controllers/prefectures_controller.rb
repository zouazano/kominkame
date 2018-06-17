class PrefecturesController < ApplicationController
	def show
		@prefecture = Prefecture.find(params[:id])
	end
end
