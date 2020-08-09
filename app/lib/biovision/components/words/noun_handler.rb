# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Noun handler
      class NounHandler < LexemeHandler
        NUMBERS = {
          0 => :any,
          1 => :singular_only,
          2 => :plural_only
        }.freeze

        GENDERS = {
          0 => :feminine,
          1 => :masculine,
          2 => :neuter,
          3 => :mutual
        }.freeze

        def self.wordform_flags
          super.merge(number_flags).merge(case_flags).merge(noun_case_flags)
        end

        def self.lexeme_data_flags
          super + %w[has_locative has_partitive animated proper_name]
        end

        def self.lexeme_data_enum
          {
            number: NUMBERS,
            gender: GENDERS
          }
        end

        def locative?
          lexeme.flag?(:has_locative)
        end

        def partitive?
          lexeme.flag?(:has_partitive)
        end

        def gender
          GENDERS[lexeme.data['gender'].to_i]
        end

        def number
          NUMBERS[lexeme.data['number'].to_i]
        end
      end
    end
  end
end
