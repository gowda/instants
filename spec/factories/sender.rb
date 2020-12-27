# frozen_string_literal: true

FactoryBot.define do
  factory :sender do
    sequence(:name) { |n| "Sender #{n}" }
  end
end
