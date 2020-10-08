# frozen_string_literal: true

# Lexeme in text corpus sample
# 
# Attributes:
#   corpus_text_id [CorpusText]
#   lexeme_id [Lexeme]
#   weight [integer]
class CorpusTextLexeme < ApplicationRecord
  belongs_to :corpus_text, counter_cache: :lexeme_count
  belongs_to :lexeme

  validates_uniqueness_of :lexeme_id, scope: :corpus_text_id
end
