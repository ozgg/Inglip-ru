# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Pronoun handler
      class PronounHandler < LexemeHandler
        TYPES = {
          0 => :personal, # Личное
          1 => :possessive, # Притяжательное
          2 => :reflexive, # Возвратное
          3 => :indefinite, # Неопределённое
          4 => :demonstrative, # Указательное
          5 => :interrogative, # Вопросительное
          6 => :relative, # Относительное
          7 => :reciprocal, # Взаимное
          8 => :definitive, # Определительное
          9 => :negatory, # Отрицательное
        }.freeze

        def self.lexeme_data_flags
          %w[adjective]
        end

        def self.lexeme_data_enum
          {
            type: TYPES
          }
        end

        def self.wordform_flags
          super.merge(case_flags).merge(gender_flags).merge(number_flags)
        end
      end
    end
  end
end
