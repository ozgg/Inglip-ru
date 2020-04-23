# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Numeral handler
      class NumeralHandler < LexemeHandler
        TYPES = {
          0 => :quantitative,
          1 => :collective,
          2 => :ordinal,
          3 => :fractional
        }.freeze

        def self.wordform_flags
          super.merge(gender_flags).merge(case_flags)
        end

        def self.lexeme_data_flags
          super + %w[gender defined_number]
        end
      end
    end
  end
end
