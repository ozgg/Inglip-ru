FactoryGirl.define do
  factory :lexeme_group do
    sequence(:name) { |n| "Группа лексем #{n}" }
    sequence(:slug) { |n| "Lexeme goup #{n}" }
  end
end
