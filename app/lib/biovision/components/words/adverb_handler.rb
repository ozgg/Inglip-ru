# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Adverb handler
      class AdverbHandler < LexemeHandler
        def self.lexeme_data_flags
          super + %w[qualitative]
        end

        def self.wordform_flags
          super.merge(comparative_form_flags).merge(superlative_form_flags)
        end
      end
    end
  end
end
