# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Parenthesis handler
      class ParenthesisHandler < LexemeHandler
        def self.lexeme_data_flags
          super + %w[long]
        end
      end
    end
  end
end
