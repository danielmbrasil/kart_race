# frozen_string_literal: true

# Placement
class Placement < ApplicationRecord
  belongs_to :racer

  validates :position,
            presence: true,
            numericality: { only_integer: true }
end
