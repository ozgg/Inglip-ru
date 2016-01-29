class Lexeme < ActiveRecord::Base
  enum part: %i(noun verb preposition adjective adverb conjunction pronoun particle numeral interjection)
end
