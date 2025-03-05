FactoryBot.define do
  factory :user do
    password { "secret123" }
    sequence(:email) { |n| "user#{n}@example.com" }
    trait :blocked do

      after(:build) do |user|
        user.block
      end
    end
  end
end
