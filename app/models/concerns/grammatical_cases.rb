module GrammaticalCases
  extend ActiveSupport::Concern

  module ClassMethods
    def grammatical_cases
      masculine_cases.merge(feminine_cases).merge(neuter_cases).merge(plural_cases)
    end

    def masculine_cases
      {
          nominative_masculine: 1, genitive_masculine: 2, partitive_masculine: 3,
          dative_masculine: 4, accusative_inanimate_masculine: 5, accusative_animate_masculine: 6,
          instrumental_masculine: 7, prepositional_masculine: 8, locative_masculine: 9
      }
    end

    def feminine_cases
      {
          nominative_feminine: 11, genitive_feminine: 12, partitive_feminine: 13,
          dative_feminine: 14, accusative_inanimate_feminine: 15, accusative_animate_feminine: 16,
          instrumental_feminine: 17, prepositional_feminine: 18, locative_feminine: 19
      }
    end

    def neuter_cases
      {
          nominative_neuter: 21, genitive_neuter: 22, partitive_neuter: 23,
          dative_neuter: 24, accusative_inanimate_neuter: 25, accusative_animate_neuter: 26,
          instrumental_neuter: 27, prepositional_neuter: 28, locative_neuter: 29
      }
    end

    def plural_cases
      {
          nominative_plural: 31, genitive_plural: 32, partitive_plural: 33,
          dative_plural: 34, accusative_inanimate_plural: 35, accusative_animate_plural: 36,
          instrumental_plural: 37, prepositional_plural: 38, locative_plural: 39
      }
    end
  end
end