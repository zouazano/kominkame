# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :houses
  has_many :inquiries
end
