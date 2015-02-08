class Noun < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :nominative
  validates_presence_of :nominative, :genitive, :dative, :accusative, :instrumental, :prepositional

  enum grammatical_gender: [:masculine, :feminine, :neuter]
  enum grammatical_number: [:both, :singular_only, :plural_only]

  def decline(grammatical_case, number = :single)
    case grammatical_case
      when :genitive
        number === :single ? genitive : plural_genitive
      when :dative
        number === :single ? dative : plural_dative
      when :accusative
        number === :single ? accusative : plural_accusative
      when :instrumental
        number === :single ? instrumental : plural_instrumental
      when :prepositional
        number === :single ? prepositional : plural_prepositional
      when :locative
        locative number
      else
        number === :single ? nominative : plural_nominative
    end
  end

  def locative(number)
    if has_locative?
      number === :single ? dative : plural_dative
    else
      number === :single ? prepositional : plural_prepositional
    end
  end

  def in_nominative(number)
    if number === :single
      nominative
    else
      (self.plural_only? || self.singular_only?) ? nominative : plural_nominative
    end
  end

  def number
    if self.singular_only?
      :single
    elsif self.plural_only?
      :plural
    end
  end
end
