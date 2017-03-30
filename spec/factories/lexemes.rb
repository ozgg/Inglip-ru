FactoryGirl.define do
  factory :lexeme do
    lexeme_group
    sequence(:body) { |n| "лексема-#{n}" }
  end
end
