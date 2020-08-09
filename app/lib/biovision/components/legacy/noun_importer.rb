# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for adjectives from CSV
      class NounImporter < BaseImporter
        GENDERS = { 0 => 1, 1 => 0, 2 => 2 }.freeze
        FLAGS = {
          nominative: 1 << 6 | 1 << 4,
          genitive: 1 << 7 | 1 << 4,
          dative: 1 << 8 | 1 << 4,
          accusative: 1 << 9 | 1 << 4,
          instrumental: 1 << 10 | 1 << 4,
          prepositional: 1 << 11 | 1 << 4,
          plural_nominative: 1 << 6 | 1 << 5,
          plural_genitive: 1 << 7 | 1 << 5,
          plural_dative: 1 << 8 | 1 << 5,
          plural_accusative: 1 << 9 | 1 << 5,
          plural_instrumental: 1 << 10 | 1 << 5,
          plural_prepositional: 1 << 11 | 1 << 5,
          partitive: 1 << 12,
          locative: 1 << 13
        }.freeze

        def handler_class
          Biovision::Components::Words::NounHandler
        end

        def lexeme_type
          LexemeType['noun']
        end

        def infinitive_key
          'nominative'
        end

        def wordforms
          result = {}
          @row.each do |k, v|
            next if v.blank? || !FLAGS.include?(k.to_sym)

            result[FLAGS[k.to_sym]] = v
          end

          result
        end

        def lexeme_data
          result = {}
          result[:number] = @row['grammatical_number'].to_i
          result[:gender] = GENDERS[@row['grammatical_gender'].to_i]
          result['has_locative'] = '1' if @row['has_locative'] == 't'
          result['has_partitive'] = '1' if @row['has_partitive'] == 't'
          result['animated'] = '1' if @row['animated'] == 't'
          result[:gender] = 3 if @row['mutual_gender'] == 't'

          result
        end
      end
    end
  end
end
