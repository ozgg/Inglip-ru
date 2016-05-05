class PartOfSpeech::Numeral < PartOfSpeech
  include GrammaticalCases

  def self.indicators
    super.merge(grammatical_cases)
  end

  # Числительное-прилагательное (например, «первый»)?
  def adjective?
    @lexeme.data['adjective']
  end
end
