# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for adverbs from CSV
      class AdverbImporter < BaseImporter
        FAMILIES = %i[conduct measure time place reason totality].freeze

        def self.handler_class
          Biovision::Components::Words::AdverbHandler
        end

        def self.lexeme_type
          LexemeType['adverb']
        end

        def attributes
          {
            lexeme_type: self.class.lexeme_type,
            body: @row['body'],
            context: FAMILIES[@row['family'].to_i]
          }
        end

        def wordforms
          flag = self.class.handler_class.wordform_flags[:comparative]
          { flag => @row['comparative_degree'] }
        end

        private

        def lexeme_data
          result = {}
          result['qualitative'] = '1' if @row['is_comparative'] == 't'

          result
        end
      end
    end
  end
end
