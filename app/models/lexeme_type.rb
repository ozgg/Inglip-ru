class LexemeType < ApplicationRecord
  include RequiredUniqueSlug
  include RequiredUniqueName

  has_many :lexemes, dependent: :delete_all

  scope :list_for_administration, -> { ordered_by_name }
end
