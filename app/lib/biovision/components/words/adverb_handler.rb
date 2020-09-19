# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Adverb handler
      class AdverbHandler < LexemeHandler
        FAMILIES = {
          0 => :conduct,
          1 => :measure,
          2 => :time,
          3 => :place,
          4 => :reason,
          5 => :totality
        }.freeze

        def self.lexeme_data_enum
          {
            family: FAMILIES
          }
        end

        def self.lexeme_data_flags
          %w[qualitative superlative]
        end

        def self.wordform_flags
          super.merge(comparative_form_flags).merge(superlative_form_flags)
        end

        def qualitative?
          lexeme.flag?(:qualitative)
        end

        def superlative?
          lexeme.flag?(:superlative)
        end
      end
    end
  end
end
