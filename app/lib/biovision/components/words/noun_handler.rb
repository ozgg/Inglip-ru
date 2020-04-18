# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Noun handler
      class NounHandler < LexemeHandler
        NUMBERS = {
          0 => :any,
          1 => :single_only,
          2 => :plural_only
        }.freeze

        def self.wordform_flags
          super.merge(number_flags).merge(case_flags)
        end

        def self.lexeme_data_flags
          super + %w[has_locative has_partitive mutual_gender]
        end

        def self.lexeme_data_enum
          {
            number: NUMBERS
          }
        end
      end
    end
  end
end
