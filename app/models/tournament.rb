# frozen_string_literal: true

# Tournament
class Tournament < ApplicationRecord
  has_many :races

  validates :name, presence: true
end
