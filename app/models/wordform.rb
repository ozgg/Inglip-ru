# frozen_string_literal: true

# Wordform
#
# Attributes:
#   created_at [DateTime]
#   flags [Integer]
#   lexeme_id [Lexeme]
#   updated_at [DateTime]
#   word_id [Word]
class Wordform < ApplicationRecord
  belongs_to :word, counter_cache: :wordforms_count
  belongs_to :lexeme, counter_cache: :wordforms_count

  validates_uniqueness_of :word_id, scope: :lexeme_id
end
