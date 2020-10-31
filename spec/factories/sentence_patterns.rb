FactoryBot.define do
  factory :sentence_pattern do
    corpus { nil }
    weight { 1 }
    sample { "MyString" }
    pattern { "MyString" }
  end
end
