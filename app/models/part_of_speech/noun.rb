class PartOfSpeech::Noun < PartOfSpeech
  include GrammaticalCases

  def self.indicators
    super.merge(grammatical_cases)
  end

  # Род
  #
  # @return [String] 'masculine'|'feminine'|'neuter'|'mutual'
  def gender
    @lexeme.data['gender']
  end

  # Одушевлённое?
  def animated?
    @lexeme.data['animated']
  end

  # Несклоняемое?
  def indeclinable?
    @lexeme.data['indeclinable']
  end

  def plural?
    @lexeme.data['plural']
  end
end
