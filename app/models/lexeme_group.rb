class LexemeGroup < ApplicationRecord
  include RequiredUniqueName
  include RequiredUniqueSlug

  def self.page_for_administration
    ordered_by_name
  end
end
