# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for adjectives from CSV
      class AdjectiveImporter < BaseImporter
        FLAGS = {
          nominative_masculine: 1 << 4 | 1 << 6 | 1 << 1,
          genitive_masculine: 1 << 4 | 1 << 7 | 1 << 1,
          dative_masculine: 1 << 4 | 1 << 8 | 1 << 1,
          accusative_masculine: 1 << 4 | 1 << 9 | 1 << 1,
          instrumental_masculine: 1 << 4 | 1 << 10 | 1 << 1,
          prepositional_masculine: 1 << 4 | 1 << 11 | 1 << 1,
          nominative_feminine: 1 << 4 | 1 << 6 | 1 << 2,
          genitive_feminine: 1 << 4 | 1 << 7 | 1 << 2,
          dative_feminine: 1 << 4 | 1 << 8 | 1 << 2,
          accusative_feminine: 1 << 4 | 1 << 9 | 1 << 2,
          instrumental_feminine: 1 << 4 | 1 << 10 | 1 << 2,
          prepositional_feminine: 1 << 4 | 1 << 11 | 1 << 2,
          nominative_neuter: 1 << 4 | 1 << 6 | 1 << 3,
          genitive_neuter: 1 << 4 | 1 << 7 | 1 << 3,
          dative_neuter: 1 << 4 | 1 << 8 | 1 << 3,
          accusative_neuter: 1 << 4 | 1 << 9 | 1 << 3,
          instrumental_neuter: 1 << 4 | 1 << 10 | 1 << 3,
          prepositional_neuter: 1 << 4 | 1 << 11 | 1 << 3,
          nominative_plural: 1 << 5 | 1 << 6,
          genitive_plural: 1 << 5 | 1 << 7,
          dative_plural: 1 << 5 | 1 << 8,
          accusative_plural: 1 << 5 | 1 << 9,
          instrumental_plural: 1 << 5 | 1 << 10,
          prepositional_plural: 1 << 5 | 1 << 11,
          comparative: 1 << 23
        }.freeze

        def handler_class
          if @row['participle'] == 't'
            Biovision::Components::Words::ParticipleHandler
          else
            Biovision::Components::Words::AdjectiveHandler
          end
        end

        def lexeme_type
          if @row['participle'] == 't'
            LexemeType['participle']
          else
            LexemeType['adjective']
          end
        end

        def infinitive_key
          'nominative_masculine'
        end

        def wordforms
          result = {}
          @row.each do |k, v|
            next if v.blank? || !FLAGS.include?(k.to_sym)

            result[FLAGS[k.to_sym]] = v
          end

          result
        end

        private

        def lexeme_data
          result = {}
          result['qualitative'] = '1' if @row['qualitative'] == 't'

          result
        end
      end
    end
  end
end
