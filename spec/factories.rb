FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "admin#{n}@bonates.com" }
    password "dbo12345"
    admin true
  end
end