FactoryBot.define do
  factory :podcast do
    author { FactoryBot.build(:user) }
    title { "title" }
    status { "published" }

    trait :archived do
      status { "archived" }
    end
  end
end
