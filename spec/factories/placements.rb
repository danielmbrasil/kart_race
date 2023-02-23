# frozen_string_literal: true

FactoryBot.define do
  factory :placement do
    position { rand(0..100) }
    racer { create :racer }
  end
end
