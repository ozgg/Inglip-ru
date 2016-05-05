class PartOfSpeech::Adjective < PartOfSpeech
  include GrammaticalCases

  def self.indicators
    super.merge(grammatical_cases).merge(other_forms)
  end

  def self.other_forms
    {
        comparative: 40,
        short_masculine: 41, short_feminine: 42, short_neuter: 43, short_plural: 44,
    }
  end

  def comparative_form=(text)
    word      = Word.stressed text
    indicator = PartOfSpeech::Adjective.indicators[:comparative]
    Wordform.find_or_create_by! lexeme: @lexeme, word: word, indicator: indicator
  end

  # Превосходная форма?
  def superlative?
    @lexeme.data['superlative']
  end

  # Это причастие?
  def participle?
    ['active', 'passive'].include? @lexeme.data['participle']
  end
end
