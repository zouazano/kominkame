# frozen_string_literal: true

class Inquiry < ApplicationRecord
  belongs_to :house

  enum demand: { document: 0, viewing: 1, other: 2 }

  validates :name, length: { minimum: 2 }

end
