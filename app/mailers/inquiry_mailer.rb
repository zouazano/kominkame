class InquiryMailer < ApplicationMailer
	def completion_mailer
		@inquiry = params[:inquiry]
		mail(to: @inquiry.email, subject: '【kominka】物件お問い合わせありがとうございます。')
	end
end
