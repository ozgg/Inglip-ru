FactoryBot.define do
  factory :lexeme_link do
    lexeme { nil }
    other_lexeme_id { 1 }
    data { "" }
  end
end
