FactoryBot.define do
  factory :pending_word do
    word { nil }
    corpus_text { nil }
    weight { 1 }
  end
end
