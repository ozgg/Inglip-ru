class Noun < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :nominative
  validates_presence_of :nominative, :genitive, :dative, :accusative, :instrumental, :prepositional

  enum grammatical_gender: [:masculine, :feminine, :neuter]
  enum grammatical_number: [:both, :singular_only, :plural_only]

  def decline(grammatical_case)
    case grammatical_case
      when :genitive
        genitive
      when :dative
        dative
      when :accusative
        accusative
      when :instrumental
        instrumental
      when :prepositional
        prepositional
      when :locative
        locative
      else
        nominative
    end
  end

  def locative
    if has_locative?
      dative
    else
      prepositional
    end
  end
end
