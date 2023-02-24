# frozen_string_literal: true

# Race
class Race < ApplicationRecord
  has_many :placements
  has_many :racers, through: :placements
  belongs_to :tournament

  validates :place, presence: true
  validates :date, presence: true
end
