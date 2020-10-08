FactoryBot.define do
  factory :corpus_text_pending_word do
    corpus_text { nil }
    pending_word { nil }
    weight { 1 }
  end
end
