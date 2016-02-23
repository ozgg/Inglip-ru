class PartOfSpeech::Pronoun < PartOfSpeech
  include GrammaticalCasesWithGender

  def self.indicators
    super.merge(singular_cases).merge(masculine_cases).merge(feminine_cases).merge(neuter_cases).merge(plural_cases)
  end
end
