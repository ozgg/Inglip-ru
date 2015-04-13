class Noun < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :nominative
  validates_presence_of :nominative, :genitive, :dative, :accusative, :instrumental, :prepositional

  enum grammatical_gender: [:masculine, :feminine, :neuter]
  enum grammatical_number: [:both, :singular_only, :plural_only]

  def self.genders_for_select
    grammatical_genders.keys.to_a.map { |e| [I18n.t("activerecord.attributes.noun.grammatical_genders.#{e}"), e] }
  end

  def self.numbers_for_select
    grammatical_numbers.keys.to_a.map { |e| [I18n.t("activerecord.attributes.noun.grammatical_numbers.#{e}"), e] }
  end

  def canonical_form
    nominative
  end

  def decline(grammatical_case, number = :single)
    case grammatical_case
      when :genitive
        in_genitive number
      when :dative
        in_dative number
      when :accusative
        in_accusative number
      when :instrumental
        in_instrumental number
      when :prepositional
        in_prepositional number
      when :locative
        locative number
      else
        in_nominative number
    end
  end

  def in_nominative(number)
    if number === :single
      nominative
    else
      (self.plural_only? || self.singular_only?) ? nominative : plural_nominative
    end
  end

  def in_genitive(number)
    if number === :single
      genitive
    else
      (self.plural_only? || self.singular_only?) ? genitive : plural_genitive
    end
  end

  def in_dative(number)
    if number === :single
      dative
    else
      (self.plural_only? || self.singular_only?) ? dative : plural_dative
    end
  end

  def in_accusative(number)
    if number === :single
      accusative
    else
      (self.plural_only? || self.singular_only?) ? accusative : plural_accusative
    end
  end

  def in_instrumental(number)
    if number === :single
      instrumental
    else
      (self.plural_only? || self.singular_only?) ? instrumental : plural_instrumental
    end
  end

  def in_prepositional(number)
    if number === :single
      prepositional
    else
      (self.plural_only? || self.singular_only?) ? prepositional : plural_prepositional
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
