# frozen_string_literal: true

# Lexeme type
#
# Attributes:
#   lexemes_count [Integer]
#   name [String]
#   slug [String]
class LexemeType < ApplicationRecord
  include RequiredUniqueName
  include RequiredUniqueSlug

  has_many :lexemes, dependent: :delete_all

  scope :list_for_administration, -> { order('id asc') }
end
