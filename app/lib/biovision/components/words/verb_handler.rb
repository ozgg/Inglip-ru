# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Verb handler
      class VerbHandler < LexemeHandler
        FORMS = {
          0 => :imperfective,
          1 => :perfective,
          2 => :both
        }.freeze

        TRANSITIVITY = {
          0 => :intransitive,
          1 => :transitive,
          2 => :both
        }.freeze

        def self.wordform_flags
          sets = [tense_flags, number_flags, person_flags, verb_form_flags]
          result = super
          sets.each { |part| result.merge! part }

          result
        end

        def self.lexeme_data_flags
          lexeme_valency_flags + %w[passive]
        end

        def self.lexeme_data_numbers
          %w[valency]
        end

        def self.lexeme_data_enum
          {
            form: FORMS,
            transitivity: TRANSITIVITY
          }
        end

        def self.past_tense_flags
          result = {}
          tense_flag = tense_flags[:tense_past]
          gender_flags.each do |k, v|
            result[k] = v | number_flags[:number_singular] | tense_flag
          end
          result[:number_plural] = number_flags[:number_plural] | tense_flag
          result[:gerund] = verb_form_flags[:gerund] | tense_flag

          result
        end

        def perfective?
          lexeme.data['form'] == 1
        end
      end
    end
  end
end
