FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "example#{n}@example.com"}
    password { 'Password@1'}
  end
end