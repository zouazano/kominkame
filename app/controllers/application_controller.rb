# frozen_string_literal: true

class ApplicationController < ActionController::Base

	before_action :set_view_variant

	private

  def set_view_variant
    request.variant = :pc if !browser.device.mobile? && !browser.device.tablet?
  end

end