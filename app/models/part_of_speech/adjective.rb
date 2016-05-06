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

  # Качественное?
  #
  # У качественных прилагательных есть сравнительная форма (белый — белее)
  def qualitative?
    @lexeme.data['qualitative']
  end

  # Превосходная форма?
  #
  # У качественных прилагательных есть превосходная форма (сильный — сильнее — сильнейшний)
  def superlative?
    @lexeme.data['superlative']
  end

  # Это причастие?
  def participle?
    %w(active passive).include? @lexeme.data['participle']
  end
end
