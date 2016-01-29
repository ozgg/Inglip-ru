class Lexeme < ActiveRecord::Base
  has_many :wordforms
  has_many :words, through: :wordforms

  enum part: %i(noun verb preposition adjective adverb conjunction pronoun particle numeral interjection)

  validates_presence_of :body, :part, :decency, :body
  validates_uniqueness_of :body, scope: [:part, :context]
end
