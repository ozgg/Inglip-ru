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

        protected

        def normalize
          # add_locative unless locative?
          # add_partitive unless partitive?
        end

        # @param [Symbol] from_case
        # @param [Symbol] to_case
        def copy_case(from_case, to_case)
          %i[number_singular number_plural].each do |number_flag|
            flags = self.class.wordform_flag(number_flag, from_case)
            source = wordform(flags)
            next if source.nil?

            self[source.text] = self.class.wordform_flag(number_flag, to_case)
          end
        end

        def add_locative
          copy_case(:case_prepositional, :case_locative)
        end

        def add_partitive
          copy_case(:case_genitive, :case_partitive)
        end
      end
    end
  end
end
