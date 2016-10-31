FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  sequence(:email) { |n| "user#{n}@example.com" }
end
