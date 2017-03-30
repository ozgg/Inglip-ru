class Lexeme < ApplicationRecord
  PER_PAGE = 20

  belongs_to :lexeme_group, counter_cache: true

  before_validation { self.body = body.to_s.strip }
  before_validation { self.context = context.to_s.strip }

  validates_presence_of :body
  validates_uniqueness_of :body, scope: [:context]

  scope :ordered_by_body, -> { order('body asc') }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    ordered_by_body.page(page).per(PER_PAGE)
  end
end
