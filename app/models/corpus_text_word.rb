# frozen_string_literal: true

# Word in text corpus sample
# 
# Attributes:
#   corpus_text_id [CorpusText]
#   weight [integer]
#   word_id [Word]
class CorpusTextWord < ApplicationRecord
  belongs_to :corpus_text, counter_cache: :word_count
  belongs_to :word

  validates_uniqueness_of :word_id, scope: :corpus_text_id
end
