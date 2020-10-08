FactoryBot.define do
  factory :corpus_text do
    uuid { "" }
    corpus { nil }
    checksum { "MyString" }
    body { "MyText" }
    lexemes_count { 1 }
    words_count { 1 }
  end
end
