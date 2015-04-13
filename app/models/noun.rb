class Noun < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :nominative
  validates_presence_of :nominative, :genitive, :dative, :partitive, :accusative, :instrumental, :prepositional, :locative

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
    if (number === :single) || self.singular_only? || self.plural_only?
      message = grammatical_case.to_s
    else
      message = "plural_#{grammatical_case}"
    end

    respond_to?(message) ? send(message) : "[#{canonical_form}/#{grammatical_case}/#{number}]"
  end

  def number
    if self.singular_only?
      :single
    elsif self.plural_only?
      :plural
    end
  end
end
