# frozen_string_literal: true

FactoryBot.define do
  factory :racer do
    name { Faker::Name.name }
    born_at { Faker::Date.birthday(min_age: Racer::MIN_AGE) }
    image_url { 'https://example.com/image.jpg' }
  end
end
