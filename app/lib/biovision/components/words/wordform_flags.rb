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

        # @param [Integer] flag
        def wordform_flag_name(flag)
          result = flag
          wordform_flags.each do |k, v|
            return I18n.t("wordform.flags.#{k}", default: k) if flag.to_i == v
          end

          result
        end

        # Every lexeme must have infinitive
        def wordform_flags
          {
            infinitive: 1
          }
        end

        def gender_flags
          {
            gender_masculine: 1 << 1,
            gender_feminine: 1 << 2,
            gender_neuter: 1 << 3
          }
        end

        def number_flags
          {
            number_singular: 1 << 4,
            number_plural: 1 << 5
          }
        end

        def case_flags
          {
            case_nominative: 1 << 6,
            case_genitive: 1 << 7,
            case_dative: 1 << 8,
            case_accusative: 1 << 9,
            case_instrumental: 1 << 10,
            case_prepositional: 1 << 11,
            case_partitive: 1 << 12,
            case_locative: 1 << 13
          }
        end

        def tense_flags
          {
            tense_past: 1 << 14,
            tense_present: 1 << 15,
            tense_future: 1 << 16
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
