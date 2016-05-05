class PartOfSpeech::Pronoun < PartOfSpeech
  include GrammaticalCases

  def self.indicators
    super.merge(grammatical_cases)
  end

  # Местоимение-прилагательное (например, «мой»)?
  def adjective?
    @lexeme.data['adjective']
  end
end
