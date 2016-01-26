FactoryGirl.define do
  factory :lexeme do
    part 0
    body 'лексема'
    sequence(:context) { |n| "Контекст #{n}" }
  end
end
