# frozen_string_literal: true

module Biovision
  module Components
    module Legacy
      # Import legacy data for lexemes from CSV
      class BaseImporter
        # @param [CSV::Row] row
        def <<(row)
          @row = row
          handler = self.class.handler_class.new
          handler.create(attributes, lexeme_data)
          handler.wordforms = wordforms
        end

        def self.handler_class
          Biovision::Components::Words::LexemeHandler
        end

        def self.lexeme_type
          nil
        end

        def attributes
          {
            lexeme_type: self.class.lexeme_type,
            body: @row['name'],
            context: 'legacy'
          }
        end

        def wordforms
          { }
        end
      end
    end
  end
end
