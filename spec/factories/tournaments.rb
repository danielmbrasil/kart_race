# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    name { Faker::Name.name }
  end
end
