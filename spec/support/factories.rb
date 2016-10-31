FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  sequence(:email) { |n| "user#{n}@example.com" }

  factory :link do
    title
    url
    user
  end

  sequence(:title) { |n| "Link #{n}" }
  sequence(:url) { |n| "https://www.google.com/#{n}" }
end
