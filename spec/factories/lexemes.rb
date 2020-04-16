FactoryBot.define do
  factory :lexeme do
    lexeme_type { nil }
    declinable { false }
    wordforms_count { 1 }
    context { "MyString" }
    body { "MyString" }
    data { "" }
  end
end
