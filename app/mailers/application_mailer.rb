# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'kominka.me.info@gmail.com'
  layout 'mailer'
end
