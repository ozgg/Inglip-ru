# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Pronoun handler
      class PronounHandler < LexemeHandler
        # TBD
        # @see https://ru.wikipedia.org/wiki/Местоимение

        def self.wordform_flags
          super.merge(case_flags).merge(gender_flags).merge(number_flags)
        end
      end
    end
  end
end
