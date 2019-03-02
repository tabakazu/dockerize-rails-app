FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "sample#{n}@example.com" }
    sequence(:password) { |n| "passw0rd#{n}" }
  end
end
