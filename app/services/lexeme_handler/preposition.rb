class LexemeHandler::Preposition < LexemeHandler
  def self.allowed_lexeme_type
    'preposition'
  end

  def self.lexeme_flags
    {
      genitive:      0b0000_0001,
      dative:        0b0000_0010,
      acusative:     0b0000_0100,
      instrumental:  0b0000_1000,
      prepositional: 0b0001_0000,
      locative:      0b0010_0000,
    }
  end
end
