FactoryBot.define do
  factory :post do
    association :user
    sequence(:title) { |n| "sample title #{n}" }
    sequence(:body) { |n| "sample body #{n}" }
  end
end
