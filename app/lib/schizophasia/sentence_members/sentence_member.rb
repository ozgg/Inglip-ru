# frozen_string_literal: true

module Schizophasia
  module SentenceMembers
    # Any member in sentence
    class SentenceMember
      attr_accessor :flags, :generator, :parts, :declension_flags

      # @param [Random] generator
      def initialize(generator = Random.new, flags = {})
        self.generator = generator
        self.parts = []
        self.flags = flags
        prepare
      end

      def to_s
        build
        parts.map(&:to_s).join(' ')
      end

      def prepare
        lexeme = Lexeme.offset(generator.rand(Lexeme.count)).first
        handler = Biovision::Components::Words::LexemeHandler[lexeme]
        handler.declension_flags = [:infinitive]
        parts << handler
      end

      def build
        # Prepare declension flags in handlers
      end

      # @param [Array] array
      def sample(*array)
        array[generator.rand(array.count)]
      end

      # @param [String] type
      # @param [Hash|String] criteria
      def random_lexeme(type, criteria = {})
        list = LexemeType[type].lexemes.where(criteria)
        lexeme = list.offset(generator.rand(list.count)).first
        Biovision::Components::Words::LexemeHandler[lexeme]
      end

      def random_adjective
        random_lexeme('adjective')
      end

      def random_participle
        random_lexeme('participle')
      end

      def random_noun
        random_lexeme('noun')
      end

      def random_verb
        random_lexeme('verb')
      end

      def random_adverb
        random_lexeme('adverb')
      end

      # @param [Symbol|nil] valency
      def random_preposition(valency = nil)
        criteria = valency.blank? ? {} : "(data->>'#{valency}')::boolean = true"
        random_lexeme('preposition', criteria)
      end
    end
  end
end
