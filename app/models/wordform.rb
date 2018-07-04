class Wordform < ApplicationRecord
  belongs_to :lexeme, counter_cache: true
  belongs_to :word, counter_cache: true

  validates_uniqueness_of :word_id, scope: [:lexeme_id, :flags]
end
