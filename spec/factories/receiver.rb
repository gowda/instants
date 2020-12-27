# frozen_string_literal: true

FactoryBot.define do
  factory :receiver do
    sequence(:name) { |n| "Receiver #{n}" }

    trait :with_whatsapp do
      transient do
        need_whatsapp { true }
      end
    end

    trait :with_imessage do
      transient do
        need_imessage { true }
      end
    end

    trait :with_sms do
      transient do
        need_sms { true }
      end
    end

    factory :receiver_with_all_transports, traits: %i[with_whatsapp with_imessage with_sms]

    after(:create) do |receiver, evaluator|
      receiver.create_whatsapp if evaluator.respond_to?(:need_whatsapp) && evaluator.need_whatsapp
      receiver.create_imessage if evaluator.respond_to?(:need_imessage) && evaluator.need_imessage
      receiver.create_sms if evaluator.respond_to?(:need_sms) && evaluator.need_sms
    end
  end
end
