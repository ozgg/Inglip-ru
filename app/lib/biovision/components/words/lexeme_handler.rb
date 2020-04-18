# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Common handler for lexemes
      class LexemeHandler
        extend LexemeData
        extend WordformFlags

        attr_accessor :lexeme

        # @param [Lexeme] lexeme
        def self.[](lexeme)
          handler_name = "biovision/components/words/#{lexeme.lexeme_type.slug}"
          handler_class = "#{handler_name}_handler".classify.constantize
          handler = handler_class.new
          handler.lexeme = lexeme
          handler
        end

        # @param [String] body
        # @param [Integer] flags
        def []=(body, flags)
          return if lexeme.nil?

          link = lexeme.wordforms.find_or_initialize_by(word: Word[body])
          link.flags |= flags
          link.save
        end

        # @param [Integer] flags
        def wordform(flags)
          f = flags.to_i
          return if f.zero?

          lexeme.wordforms.find_by("flags & #{f} = #{f}")
        end

        # @param [Symbol] keys
        def decline(*keys)
          return if lexeme.nil?

          flags = self.class.wordform_flag(*keys)
          word = wordform(flag)&.word

          word&.body || "[#{lexeme.body}:#{flags}]"
        end

        # @param [Hash] attributes
        def create(attributes, lexeme_data)
          lexeme = Lexeme.new(attributes)
          lexeme.data = self.class.normalized_lexeme_data(lexeme_data)
          if lexeme.save
            self[lexeme.body] = self.class.wordform_flags[:infinitive]
          end
          self.lexeme = lexeme
          lexeme
        end
      end
    end
  end
end
