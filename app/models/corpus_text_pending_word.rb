# frozen_string_literal: true

# Pending word in text corpus sample
# 
# Attributes:
#   corpus_text_id [CorpusText]
#   pending_word_id [PendingWord]
#   weight [integer]
class CorpusTextPendingWord < ApplicationRecord
  belongs_to :corpus_text, counter_cache: :pending_word_count
  belongs_to :pending_word

  validates_uniqueness_of :pending_word_id, scope: :corpus_text_id
end
