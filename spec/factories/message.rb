# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "message #{n}" }

    trait :with_sender do
      sender
    end
  end
end
