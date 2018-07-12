# frozen_string_literal: true

class Inquiry < ApplicationRecord
  belongs_to :house

  enum demand: { document: 0, viewing: 1, other: 2 }

  validates :name, length: { minimum: 2 }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :phonenumber, presence: true
  validates :address, presence: true

end