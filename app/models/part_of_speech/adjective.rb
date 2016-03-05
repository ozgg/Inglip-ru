class PartOfSpeech::Adjective < PartOfSpeech
  include GrammaticalCasesWithGender

  def self.indicators
    super.merge(masculine_cases).merge(feminine_cases).merge(neuter_cases).merge(plural_cases).merge(other_forms)
  end

  def self.other_forms
    {
        comparative: 50,
        short_masculine: 51, short_feminine: 52, short_neuter: 53, short_plural: 54,
    }
  end

  def comparative_form=(text)
    word      = Word.stressed text
    indicator = PartOfSpeech::Adjective.indicators[:comparative]
    Wordform.find_or_create_by! lexeme: @lexeme, word: word, indicator: indicator
  end
end
