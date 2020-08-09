# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for verbs from CSV
      class VerbImporter < BaseImporter
        FLAGS = {
          imperative: 1 << 20 | 1 << 4,
          gerund: 1 << 21 | 1 << 15,
          gerund_past: 1 << 21 | 1 << 14,
          present_first: 1 << 15 | 1 << 17 | 1 << 4,
          present_second: 1 << 15 | 1 << 18 | 1 << 4,
          present_third: 1 << 15 | 1 << 19 | 1 << 4,
          present_first_plural: 1 << 15 | 1 << 17 | 1 << 5,
          present_second_plural: 1 << 15 | 1 << 18 | 1 << 5,
          present_third_plural: 1 << 15 | 1 << 19 | 1 << 5,
          past_masculine: 1 << 14 | 1 << 1 | 1 << 4,
          past_feminine: 1 << 14 | 1 << 2 | 1 << 4,
          past_neuter: 1 << 14 | 1 << 3 | 1 << 4,
          past_plural: 1 << 14 | 1 << 5,
          future_first: 1 << 16 | 1 << 17 | 1 << 4,
          future_second: 1 << 16 | 1 << 18 | 1 << 4,
          future_third: 1 << 16 | 1 << 19 | 1 << 4,
          future_first_plural: 1 << 16 | 1 << 17 | 1 << 5,
          future_second_plural: 1 << 16 | 1 << 18 | 1 << 5,
          future_third_plural: 1 << 16 | 1 << 19 | 1 << 5
        }.freeze

        def handler_class
          Biovision::Components::Words::VerbHandler
        end

        def lexeme_type
          LexemeType['verb']
        end

        def infinitive_key
          'infinitive'
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
          result[:forms] = 1 if @row.key?('passive_masculine')
          result['passive'] = '1' if @row['infinitive'].end_with?('ся')
          result['valency'] = @row['valency'].to_i

          result
        end
      end
    end
  end
end
