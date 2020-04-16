FactoryBot.define do
  factory :word do
    wordforms_count { 1 }
    body { "MyString" }
  end
end
