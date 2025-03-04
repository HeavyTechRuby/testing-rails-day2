FactoryBot.define do
  factory :user do
    trait :blocked do

      after(:build) do |user|
        user.block
      end
    end
  end
end
