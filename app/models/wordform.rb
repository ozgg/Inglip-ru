class Wordform < ActiveRecord::Base
  belongs_to :lexeme
  belongs_to :word

  validates_presence_of :lexeme_id, :word_id, :indicator

  enum indicator: [
                      :infinitive,
                  ]
end
