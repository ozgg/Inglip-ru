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

        GENDERS = {
          0 => :feminine,
          1 => :masculine,
          2 => :neuter,
          3 => :mutual
        }.freeze

        def self.wordform_flags
          super.merge(number_flags).merge(case_flags)
        end

        def self.lexeme_data_flags
          super + %w[has_locative has_partitive]
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

        protected

        def normalize
          mix_locative unless locative?
          mix_partitive unless partitive?
          super
        end

        def mix_locative
          flags = self.class.wordform_flags
          lexeme.wordforms.with_flag(flags[:prepositional]).each do |wordform|
            wordform.add_flag! flags[:locative]
          end
        end

        def mix_partitive
          flags = self.class.wordform_flags
          lexeme.wordforms.with_flag(flags[:genitive]).each do |wordform|
            wordform.add_flag! flags[:partitive]
          end
        end
      end
    end
  end
end
