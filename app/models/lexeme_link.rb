# frozen_string_literal: true

# Semantic link between lexemes
#
# Attributes:
#   created_at [DateTime]
#   data [Json]
#   lexeme_id [Lexeme]
#   other_lexeme_id [Lexeme]
#   updated_at [DateTime]
class LexemeLink < ApplicationRecord
  belongs_to :lexeme
  belongs_to :other_lexeme, class_name: Lexeme.to_s

  validates_uniqueness_of :other_lexeme_id, scope: :lexeme_id
end
