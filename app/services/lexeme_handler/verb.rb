class LexemeHandler::Verb < LexemeHandler
  def self.allowed_lexeme_type
    'verb'
  end

  def self.lexeme_flags
    {
      perfective:   0b0001,
      transitive:   0b0010,
      passive_mood: 0b0100
    }
  end
end
