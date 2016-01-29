class Word < ActiveRecord::Base
  has_many :wordforms
  has_many :lexemes, through: :wordforms

  validates_presence_of :body
  validates_uniqueness_of :body, scope: [:stress]
end
