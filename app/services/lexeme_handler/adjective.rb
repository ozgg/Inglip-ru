class LexemeHandler::Adjective < LexemeHandler
  def self.allowed_lexeme_type
    'adjective'
  end

  def self.lexeme_flags
    {
      qualitative: 0b0001,
      superlative: 0b0010,
    }
  end
end
