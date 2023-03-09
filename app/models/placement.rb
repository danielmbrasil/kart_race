# frozen_string_literal: true

# Placement
class Placement < ApplicationRecord
  belongs_to :racer
  belongs_to :race

  validates :position,
            uniqueness: { scope: :race_id },
            numericality: {
              only_integer: true,
              greater_than: 0
            }

  validates :racer_id, uniqueness: { scope: :race_id }

  FIRST_PLACE_POINTS = 5
  SECOND_PLACE_POINTS = 3
  THIRD_PLACE_POINTS = 2
end
