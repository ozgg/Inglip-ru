FactoryBot.define do
  factory :corpus do
    uuid { "" }
    user { nil }
    agent { nil }
    ip_address { nil }
    corpus_texts_count { 1 }
    lexemes_count { 1 }
    name { "MyString" }
  end
end
