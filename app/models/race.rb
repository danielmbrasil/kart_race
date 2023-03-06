# frozen_string_literal: true

# Race
class Race < ApplicationRecord
  has_many :placements
  has_many :racers, through: :placements
  belongs_to :tournament

  validates :place, presence: true
  validates :date, presence: true

  accepts_nested_attributes_for :placements,
                                reject_if: proc { |attributes|
                                  attributes['racer_id'].blank? || attributes['position'].blank?
                                }, allow_destroy: true
end
