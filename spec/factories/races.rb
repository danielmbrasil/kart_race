# frozen_string_literal: true

FactoryBot.define do
  factory :race do
    place { Faker::Address.city }
    date { Date.today }
  end
end
