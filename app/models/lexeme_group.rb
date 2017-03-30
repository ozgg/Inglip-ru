class LexemeGroup < ApplicationRecord
  include RequiredUniqueName
  include RequiredUniqueSlug

  has_many :lexemes, dependent: :destroy

  def self.page_for_administration
    ordered_by_name
  end
end
