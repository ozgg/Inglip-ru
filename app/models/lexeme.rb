class Lexeme < ActiveRecord::Base
  has_many :words, dependent: :destroy
  enum part: %i(noun verb preposition adjective adverb conjunction pronoun particle numeral interjection)
end
