# frozen_string_literal: true

module Sentence
  # Sentence member
  class SentenceMember
    include WordformFlags

    attr_accessor :generator, :handler
    attr_reader :flags

    # @param [Integer|nil] seed
    # @param [Lexeme] lexeme
    def initialize(seed = nil, lexeme = nil)
      self.generator = Random.new(seed || Random.new_seed)
      @flags = []
      init_handler(lexeme)
      randomize_flags
    end

    def to_s
      handler.decline(*@flags)
    end

    # @param [Lexeme|nil] lexeme
    def init_handler(lexeme = nil)
      lexeme ||= random_lexeme
      self.handler = Biovision::Components::Words::LexemeHandler[lexeme]
    end

    def random_lexeme
      Lexeme.offset(generator.rand(Lexeme.count)).first
    end

    def seed
      generator.seed
    end

    # @param [Symbol] flag
    def remove_flag(flag)
      @flags -= [flag]
    end

    # @param [Symbol] flag
    def add_flag(flag)
      @flags << flag unless @flags.include?(flag)
    end

    def reset_flags
      @flags = []
    end

    # @param [Symbol] flag
    def flag?(flag)
      @flags.include? flag
    end

    # @param [Array] permitted
    def randomize_flags(permitted = handler.class.wordform_flags.keys)
      @flags = permitted & [:infinitive]
    end

    # @param [Array] set
    def sample(set)
      return if set.empty?

      set[generator.rand(set.count)]
    end
  end
end
