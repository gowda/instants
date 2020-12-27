# frozen_string_literal: true

FactoryBot.define do
  factory :sender do
    name { Faker::Name.unique.name }
  end
end
