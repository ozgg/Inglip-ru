class Noun < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :nominative
  validates_presence_of :nominative, :genitive, :dative, :instrumental, :prepositional

  enum grammatical_gender: [:masculine, :feminine, :neuter]
  enum grammatical_number: [:both, :singular_only, :plural_only]
end
