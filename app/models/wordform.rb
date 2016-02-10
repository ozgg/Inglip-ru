class Wordform < ActiveRecord::Base
  belongs_to :lexeme
  belongs_to :word

  validates_presence_of :lexeme_id, :word_id, :indicator
  validates_uniqueness_of :indicator, scope: [:lexeme_id, :word_id]

  enum indicator: [
                      :infinitive,
                      :nominative_singular, :nominative_plural,
                      :genitive_singular, :genitive_plural,
                      :partitive_singular, :partitive_plural,
                      :dative_singular, :dative_plural,
                      :accusative_animate_singular, :accusative_animate_plural,
                      :accusative_inanimate_singular, :accusative_inanimate_plural,
                      :instrumental_singular, :instrumental_plural,
                      :prepositional_singular, :prepositional_plural,
                      :locative_singular, :locative_plural
                  ]

  scope :as_infinitive, -> { where indicator: Wordform.indicators[:infinitive] }
end
