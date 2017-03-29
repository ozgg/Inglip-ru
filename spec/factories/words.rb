FactoryGirl.define do
  factory :word do
    sequence(:body) { |n| "Слово-#{n}" }
  end
end
