module GrammaticalCasesWithGender
  extend ActiveSupport::Concern

  module ClassMethods
    def singular_cases
      {
          nominative_singular: 1, genitive_singular: 2, dative_singular: 4,
          accusative_singular: 5, instrumental_singular: 6, prepositional_singular: 7
      }
    end

    def masculine_cases
      {
          nominative_masculine: 11, genitive_masculine: 12, dative_masculine: 13,
          accusative_animate_masculine: 14, accusative_inanimate_masculine: 15, instrumental_masculine: 16,
          prepositional_masculine: 17
      }
    end

    def feminine_cases
      {
          nominative_feminine: 21, genitive_feminine: 22, dative_feminine: 23,
          accusative_animate_feminine: 24, accusative_inanimate_feminine: 25, instrumental_feminine: 26,
          prepositional_feminine: 27
      }
    end

    def neuter_cases
      {
          nominative_neuter: 31, genitive_neuter: 32, dative_neuter: 33,
          accusative_animate_neuter: 34, accusative_inanimate_neuter: 35, instrumental_neuter: 36,
          prepositional_neuter: 37
      }
    end

    def plural_cases
      {
          nominative_plural: 41, genitive_plural: 42, dative_plural: 43,
          accusative_animate_plural: 44, accusative_inanimate_plural: 45, instrumental_plural: 46,
          prepositional_plural: 47
      }
    end
  end
end