class Adjective < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :nominative_masculine
  validates_presence_of :nominative_masculine, :nominative_feminine, :nominative_neuter, :nominative_plural
  validates_presence_of :genitive_masculine, :genitive_feminine, :genitive_neuter, :genitive_plural
  validates_presence_of :dative_masculine, :dative_feminine, :dative_neuter, :dative_plural
  validates_presence_of :accusative_masculine, :accusative_feminine, :accusative_neuter, :accusative_plural
  validates_presence_of :instrumental_masculine, :instrumental_feminine, :instrumental_neuter, :instrumental_plural
  validates_presence_of :prepositional_masculine, :prepositional_feminine, :prepositional_neuter, :prepositional_plural

  def canonical_form
    nominative_masculine
  end

  def decline(gender, number, grammatical_case)
    if number === :single
      message = "#{grammatical_case}_#{gender}"
    else
      message = "#{grammatical_case}_plural"
    end

    respond_to?(message) ? send(message) : "[#{canonical_form}/#{gender}/#{number}/#{grammatical_case}]"
  end

  def partitive_masculine
    genitive_masculine
  end

  def partitive_feminine
    genitive_feminine
  end

  def partitive_neuter
    genitive_neuter
  end

  def partitive_plural
    genitive_plural
  end

  def locative_masculine
    prepositional_masculine
  end

  def locative_feminine
    prepositional_feminine
  end

  def locative_neuter
    prepositional_neuter
  end

  def locative_plural
    prepositional_plural
  end
end