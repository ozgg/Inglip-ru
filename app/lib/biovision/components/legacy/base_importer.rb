# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for lexemes from CSV
      class BaseImporter
        # @param [CSV::Row] row
        def <<(row)
          @row = row
          handler = handler_class.new
          handler.create(attributes, lexeme_data)
          handler.wordforms = wordforms
        end

        def handler_class
          Biovision::Components::Words::LexemeHandler
        end

        def lexeme_type
          nil
        end

        def infinitive_key
          ''
        end

        def attributes
          {
            lexeme_type: lexeme_type,
            body: @row[infinitive_key],
            context: 'legacy'
          }
        end

        def wordforms
          { }
        end

        def lexeme_data
          { }
        end
      end
    end
  end
end
