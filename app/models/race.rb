# frozen_string_literal: true

# Race
class Race < ApplicationRecord
  has_many :placements
  has_many :racers, through: :placements

  validates :place, presence: true
  validates :date, presence: true
end
