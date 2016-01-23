FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user_#{n}" }
    password 'secret'
    password_confirmation 'secret'
  end
end
