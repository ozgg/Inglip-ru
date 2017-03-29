class Word < ApplicationRecord
  PER_PAGE = 20

  validates_presence_of :body
  validates_uniqueness_of :body

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    order('body asc').page(page).per(PER_PAGE)
  end
end
