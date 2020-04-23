# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Helpers for settings wordform flags
      module WordformFlags
        # @param [Symbol]
        def wordform_flag(*keys)
          keys.map { |key| wordform_flags[key].to_i }.sum
        end

        # Every lexeme must have infinitive
        def wordform_flags
          {
            infinitive: 0b0001 # 0
          }
        end

        def gender_flags
          {
            gender_masculine: 0b0010, # 1
            gender_feminine: 0b0100, # 2
            gender_neuter: 0b1000 # 3
          }
        end

        def number_flags
          {
            number_singular: 0b0001_0000, # 4
            number_plural: 0b0010_0000 # 5
          }
        end

        def case_flags
          {
            case_nominative: 0b0000_0000_0100_0000, # 6
            case_genitive: 0b0000_0000_1000_0000, # 7
            case_dative: 0b0000_0001_0000_0000, # 8
            case_accusative: 0b0000_0010_0000_0000, # 9
            case_instrumental: 0b0000_0100_0000_0000, # 10
            case_prepositional: 0b0000_1000_0000_0000, # 11
            case_partitive: 0b0001_0000_0000_0000, # 12
            case_locative: 0b0010_0000_0000_0000 # 13
          }
        end

        def tense_flags
          {
            tense_past: 0b0000_0100_0000_0000_0000, # 14
            tense_present: 0b0000_1000_0000_0000_0000, # 15
            tense_future: 0b0001_0000_0000_0000_0000 # 16
          }
        end

        def person_flags
          {
            person_first: 1 << 17,
            person_second: 1 << 18,
            person_third: 1 << 19
          }
        end

        def verb_form_flags
          {
            imperative: 1 << 20,
            gerund: 1 << 21
          }
        end

        def adjective_form_flags
          {
            short_form: 1 << 22
          }
        end

        def comparative_form_flags
          {
            comparative: 1 << 23
          }
        end

        def superlative_form_flags
          {
            superlative: 1 << 24
          }
        end

        def preposition_form_flags
          {
            vowel_ending: 1 << 25,
            consonant_ending: 1 << 26
          }
        end
      end
    end
  end
end
