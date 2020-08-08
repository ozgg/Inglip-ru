# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for adverbs from CSV
      class AdverbImporter < BaseImporter
        FAMILIES = %i[conduct measure time place reason totality].freeze

        def handler_class
          Biovision::Components::Words::AdverbHandler
        end

        def lexeme_type
          LexemeType['adverb']
        end

        def infinitive_key
          'body'
        end

        def attributes
          {
            lexeme_type: lexeme_type,
            body: @row[infinitive_key],
            context: FAMILIES[@row['family'].to_i]
          }
        end

        def wordforms
          { handler_class.wordform_flags[:comparative] => @row['comparative_degree'] }
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
