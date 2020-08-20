# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Participle handler
      class ParticipleHandler < LexemeHandler
        TRANSITIVITY = {
          0 => :intransitive,
          1 => :transitive,
          2 => :both
        }.freeze

        def self.lexeme_data_flags
          lexeme_valency_flags + %w[perfective passive]
        end

        def self.lexeme_data_enum
          {
            transitivity: TRANSITIVITY
          }
        end

        def self.wordform_flags
          sets = [
            gender_flags, number_flags, case_flags, adjective_form_flags,
            tense_flags.reject { |k, _| k == :tense_future }
          ]
          result = super
          sets.each { |part| result.merge! part }

          result
        end

        def perfective?
          lexeme.data['form'] == 1
        end
      end
    end
  end
end
