# frozen_string_literal: true

class ApplicationController < ActionController::Base

	before_action :set_view_variant

	before_action :set_locale
 
  def set_locale
    I18n.locale = :ja
  end

	private

  def set_view_variant
    request.variant = :pc if !browser.device.mobile? && !browser.device.tablet?
  end

end