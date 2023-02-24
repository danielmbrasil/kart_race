# frozen_string_literal: true

FactoryBot.define do
  factory :placement do
    position { rand(1..100) }
    racer { create :racer }
    race { create :race }
  end
end
