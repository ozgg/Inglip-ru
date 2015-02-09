class Adjective < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :nominative_masculine
  validates_presence_of :nominative_masculine, :nominative_feminine, :nominative_neuter, :nominative_plural
  validates_presence_of :genitive_masculine, :genitive_feminine, :genitive_neuter, :genitive_plural
  validates_presence_of :dative_masculine, :dative_feminine, :dative_neuter, :dative_plural
  validates_presence_of :instrumental_masculine, :instrumental_feminine, :instrumental_neuter, :instrumental_plural
  validates_presence_of :prepositional_masculine, :prepositional_feminine, :prepositional_neuter, :prepositional_plural

  def canonical_form
    nominative_masculine
  end
end
