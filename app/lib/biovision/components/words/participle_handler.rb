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
          super + lexeme_valency_flags + %w[perfective passive]
        end

        def self.lexeme_data_enum
          {
            transitivity: TRANSITIVITY
          }
        end

        def self.wordform_flags
          sets = [
            gender_flags, number_flags, case_flags, adjective_form_flags
          ]
          result = super
          sets.each { |part| result.merge! part }

          result
        end
      end
    end
  end
end
