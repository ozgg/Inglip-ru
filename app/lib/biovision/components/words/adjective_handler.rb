# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Adjective handler
      class AdjectiveHandler < LexemeHandler
        def self.lexeme_data_flags
          super + %w[qualitative superlative]
        end

        def self.wordform_flags
          sets = [
            gender_flags, number_flags, case_flags, adjective_form_flags,
            comparative_form_flags
          ]
          result = super
          sets.each { |part| result.merge! part }

          result
        end

        def qualitative?
          lexeme.flag?(:qualitative)
        end
      end
    end
  end
end
