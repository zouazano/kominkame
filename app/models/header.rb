# frozen_string_literal: true

class Header < ApplicationRecord
  mount_uploader :image, ImageUploader
end
