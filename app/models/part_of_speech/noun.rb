class PartOfSpeech::Noun < PartOfSpeech

  def self.indicators
    super.merge(singular_cases).merge(plural_cases)
  end

  protected

  def self.singular_cases
    {
        nominative_singular: 1, genitive_singular: 2, partitive_singular: 3, dative_singular: 4,
        accusative_singular: 5, instrumental_singular: 6, prepositional_singular: 7, locative_singular: 8,
    }
  end

  def self.plural_cases
    {
        nominative_plural: 11, genitive_plural: 12, dative_plural: 14,
        accusative_plural: 15, instrumental_plural: 16, prepositional_plural: 17,
    }
  end
end
