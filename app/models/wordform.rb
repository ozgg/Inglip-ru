# frozen_string_literal: true

# Wordform
#
# Attributes:
#   created_at [DateTime]
#   flags [Integer]
#   lexeme_id [Lexeme]
#   updated_at [DateTime]
#   word_id [Word]
class Wordform < ApplicationRecord
  belongs_to :word, counter_cache: :wordforms_count
  belongs_to :lexeme, counter_cache: :wordforms_count

  validates_uniqueness_of :word_id, scope: %i[lexeme_id flags]

  scope :with_flag, ->(f) { where(flags: f.to_i) }
  scope :ordered_by_flags, -> { order('flags asc') }
  scope :list_for_administration, -> { order('lexeme_id asc, flags asc') }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  def text
    word.body
  end

  def text_for_link
    text
  end

  # @param [Integer] flag
  def flag?(flag)
    flags & flag.to_i == flag.to_i
  end

  # @param [Integer] flag
  def add_flag!(flag)
    self.flags |= flag.to_i
    save!
  end

  # @param [Integer] flag
  def remove_flag!(flag)
    self.flags &= (0xffffffff - flag.to_i)
    save!
  end
end
