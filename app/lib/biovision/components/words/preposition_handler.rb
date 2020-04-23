# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Preposition handler
      class PrepositionHandler < LexemeHandler
        def self.lexeme_data_flags
          super + lexeme_valency_flags + %w[vowel_ending consonant_ending]
        end

        def self.wordform_flags
          super.merge(preposition_form_flags)
        end
      end
    end
  end
end
