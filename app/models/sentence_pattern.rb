# frozen_string_literal: true

# Sentence pattern
# 
# Attributes:
#   corpus_id [Corpus], optional
#   pattern [string]
#   sample [string]
#   weight [integer]
class SentencePattern < ApplicationRecord
  include Checkable

  belongs_to :corpus, optional: true

  validates_presence_of :pattern
  validates_uniqueness_of :pattern, scope: :corpus_id

  scope :ordered_by_pattern, -> { order('pattern asc') }
  scope :list_for_administration, -> { ordered_by_pattern }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  def self.entity_parameters
    %i[pattern sample]
  end

  def self.creation_parameters
    entity_parameters + %i[corpus_id]
  end
end
