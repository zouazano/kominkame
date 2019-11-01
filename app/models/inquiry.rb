# frozen_string_literal: true

class Inquiry < ApplicationRecord
  #belongs_to :rent_house
  belongs_to :buy_house
  #belongs_to :stay_house


  #enum demand: { document: 0, viewing: 1, other: 2 }

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true
  #validates :address, presence: true

end