class LexemeHandler::Noun < LexemeHandler
  def self.allowed_lexeme_type
    'noun'
  end

  def self.lexeme_flags
    {
      animated:         0b0000_0001,
      gender_masculine: 0b0000_0010,
      gender_feminine:  0b0000_0100,
      gender_neuter:    0b0000_1000,
      singular_form:    0b0001_0000,
      plural_form:      0b0010_0000,
      has_partitive:    0b0100_0000,
      has_locative:     0b1000_0000,
    }
  end
end
