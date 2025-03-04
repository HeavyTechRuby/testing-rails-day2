FactoryBot.define do
  factory :podcast do
    author { FactoryBot.build(:user) }
    title { "title" }
  end
end
