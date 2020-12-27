# frozen_string_literal: true

FactoryBot.define do
  factory :transport do
    name { Transport::NAMES.keys.sample }
  end
end
