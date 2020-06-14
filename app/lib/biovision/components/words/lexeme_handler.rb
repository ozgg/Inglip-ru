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
          handler = for_type(lexeme.lexeme_type)
          handler.lexeme = lexeme
          handler
        end

        # @param [LexemeType|BelongsToAssociation] lexeme_type
        def self.for_type(lexeme_type)
          handler_name = "biovision/components/words/#{lexeme_type.slug}"
          handler_class = "#{handler_name}_handler".classify.constantize
          handler_class.new
        end

        # @param [String] body
        # @param [Integer] flags
        def []=(body, flags)
          return if lexeme.nil? || body.blank?

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
        # @param [Hash] lexeme_data
        def create(attributes, lexeme_data)
          lexeme = Lexeme.new(attributes)
          self.lexeme = lexeme
          lexeme.data = self.class.normalized_lexeme_data(lexeme_data)
          if lexeme.save
            self[lexeme.body] = self.class.wordform_flags[:infinitive]
          end
          lexeme
        end

        # @param [Hash] data
        def wordforms=(data)
          return if data.blank?

          data.each do |flag, body|
            next if body.blank?

            self[body] = flag.to_i
          end
          normalize
        end

        # @param [Hash] attributes
        # @param [Hash] lexeme_data
        def update(attributes, lexeme_data)
          lexeme.assign_attributes(attributes)
          lexeme.data = self.class.normalized_lexeme_data(lexeme_data)
          lexeme.save
        end

        protected

        def normalize
          self[lexeme.body] = 0xffffffff unless lexeme.declinable?
        end
      end
    end
  end
end