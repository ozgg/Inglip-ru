# frozen_string_literal: true

# Pending word without word-lexeme links
# 
# Attributes:
#   body [string]
#   weight [integer]
#   word_id [Word], optional
class PendingWord < ApplicationRecord
  include Checkable

  belongs_to :word, optional: true
  has_many :corpus_text_pending_words, dependent: :delete_all
  has_many :corpus_texts, through: :corpus_text_pending_words

  validates_presence_of :body
  validates_uniqueness_of :body

  scope :ordered_by_body, -> { order('body asc') }
  scope :ordered_by_weight, -> { order('weight desc, body asc') }
  scope :list_for_administration, -> { ordered_by_weight }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  def self.entity_parameters
    %i[body]
  end
end
