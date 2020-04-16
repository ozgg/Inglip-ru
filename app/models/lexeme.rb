# frozen_string_literal: true

# Lexeme
#
# Attributes:
#   body [string]
#   context [string]
#   created_at [DateTime]
#   data [jsonb]
#   lexeme_type_id [LexemeType]
#   updated_at [DateTime]
#   wordforms_count [integer]
class Lexeme < ApplicationRecord
  include Checkable

  BODY_LIMIT = 100
  CONTEXT_LIMIT = 250

  belongs_to :lexeme_type, counter_cache: true
  has_many :wordforms, dependent: :delete_all
  has_many :words, through: :wordforms
  has_many :lexeme_links, dependent: :delete_all

  validates_uniqueness_of :body, scope: %i[lexeme_type_id context]
  validates_presence_of :body
  validates_length_of :body, maximum: BODY_LIMIT
  validates_length_of :context, maximum: CONTEXT_LIMIT

  scope :ordered_by_body, -> { order('body asc, context asc') }
  scope :list_for_administration, -> { ordered_by_body }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  def self.entity_parameters
    %i[body context]
  end

  def self.creation_parameters
    entity_parameters + %i[lexeme_type_id]
  end
end
