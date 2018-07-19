class LexemeHandler::Verb < LexemeHandler
  def self.allowed_lexeme_type
    'verb'
  end

  def self.lexeme_flags
    {
      perfective:   0b0001,
      transitional: 0b0010
    }
  end
end
