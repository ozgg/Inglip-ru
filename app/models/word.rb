# frozen_string_literal: true

# Word
#
# Attributes:
#   body [String]
#   created_at [DateTime]
#   updated_at [DateTime]
#   wordforms_count [Integer]
class Word < ApplicationRecord
  BODY_LIMIT = 100

  has_many :wordforms, dependent: :delete_all
  has_many :lexemes, through: :wordforms
  has_many :corpus_text_words, dependent: :destroy
  has_many :corpus_texts, through: :corpus_text_words

  validates_presence_of :body
  validates_uniqueness_of :body
  validates_length_of :body, maximum: BODY_LIMIT

  scope :ordered_by_body, -> { order('body asc') }
  scope :list_for_administration, -> { ordered_by_body }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  # @param [String] body
  def self.[](body)
    find_or_create_by(body: body)
  end

  def self.entity_parameters
    %i[body]
  end

  def text_for_link
    body
  end
end
