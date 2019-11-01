ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "gmail.com",
  authentication: "login",
  user_name: ENV["MAIL_USERNAME"],
  password: ENV["MAIL_PASSWORD"],
}