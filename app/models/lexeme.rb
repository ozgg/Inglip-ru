class Lexeme < ApplicationRecord
  BODY_LIMIT    = 100
  CONTEXT_LIMIT = 250

  belongs_to :lexeme_type, counter_cache: true
  has_many :wordforms, dependent: :destroy
  has_many :words, through: :wordforms

  validates_uniqueness_of :body, scope: [:lexeme_type_id, :context]
  validates_presence_of :body
  validates_length_of :body, maximum: BODY_LIMIT
  validates_length_of :context, maximum: CONTEXT_LIMIT

  scope :ordered_by_body, -> { order('body asc, context asc') }
  scope :list_for_administration, -> { ordered_by_body }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end
end
