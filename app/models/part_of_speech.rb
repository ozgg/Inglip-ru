class PartOfSpeech
  attr_accessor :lexeme

  def self.indicators
    { infinitive: 0 }
  end

  def initialize(lexeme)
    @lexeme = lexeme
  end

  def infinitive=(text)
    word = Word.stressed text
    Wordform.find_or_create_by!(lexeme: @lexeme, word: word, indicator: PartOfSpeech.indicators[:infinitive])
  end

  def infinitive
    wordform = @lexeme.wordforms.infinitive
    wordform.word.body unless wordform.blank?
  end
end