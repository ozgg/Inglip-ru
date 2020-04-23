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
          super + lexeme_valency_flags + %w[passive]
        end

        def self.lexeme_data_numbers
          %w[valency]
        end

        def self.lexeme_data_enum
          {
            forms: FORMS,
            transitivity: TRANSITIVITY
          }
        end
      end
    end
  end
end
