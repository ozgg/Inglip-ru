# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for prepositions from CSV
      class PrepositionImporter < BaseImporter
        CASES = %w[genitive dative accusative instrumental prepositional locative].freeze

        def self.handler_class
          Biovision::Components::Words::PrepositionHandler
        end

        def self.lexeme_type
          LexemeType['preposition']
        end

        private

        def lexeme_data
          result = {}
          CASES.each do |flag|
            next unless @row[flag] == 't'

            result["#{flag}_case"] = '1'
          end

          result
        end
      end
    end
  end
end
