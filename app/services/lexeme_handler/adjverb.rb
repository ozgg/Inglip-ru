class LexemeHandler::Adverb < LexemeHandler
  def self.allowed_lexeme_type
    'adverb'
  end

  def self.lexeme_flags
    {
      qualitative: 0b0001,
      adjunct:     0b0010,
      attributive: 0b0100
    }
  end
end
