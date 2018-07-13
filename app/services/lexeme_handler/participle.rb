class LexemeHandler::Participle < LexemeHandler
  def self.allowed_lexeme_type
    'participle'
  end

  def self.lexeme_flags
    {
      perfective:    0b0001,
      passive_voice: 0b0010,
    }
  end
end
