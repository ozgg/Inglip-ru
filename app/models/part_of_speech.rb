class PartOfSpeech
  attr_accessor :lexeme

  def initialize(lexeme)
    @lexeme = lexeme
  end

  def infinitive=(text)
    analyzer   = StressAnalyzer.new text
    parameters = { body: analyzer.body, stress: analyzer.stress }
    word       = Word.find_by(parameters) || Word.create!(parameters)
    parameters = { lexeme: @lexeme, word: word, indicator: Wordform.indicators[:infinitive] }
    Wordform.find_by(parameters) || Wordform.create!(parameters)
  end

  def infinitive
    wordform = @lexeme.wordforms.as_infinitive
    wordform.word.body unless wordform.blank?
  end
end