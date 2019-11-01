# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def completion_mailer
  	InquiryMailer.with(inquiry: Inquiry.last).completion_mailer
  end
end
