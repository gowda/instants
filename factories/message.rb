# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "Message #{n}" }
  end
end
