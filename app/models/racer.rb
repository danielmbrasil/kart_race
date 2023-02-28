# frozen_string_literal: true

require 'uri'

# Racer
class Racer < ApplicationRecord
  MIN_AGE = 18

  validates :name, presence: true
  validates :born_at, presence: true
  validates :image_url, allow_blank: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validate :must_be_over_min_age

  has_many :placements
  has_many :races, through: :placements

  private

  def must_be_over_min_age
    return unless born_at.present?

    errors.add(:born_at, "must be at least #{MIN_AGE} years old") unless born_at <= MIN_AGE.years.ago.to_date
  end
end
