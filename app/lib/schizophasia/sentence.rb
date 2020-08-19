# frozen_string_literal: true

module Schizophasia
  # Generated sentence
  class Sentence
    attr_accessor :flags, :generator, :parts

    # @param [Random] generator
    def initialize(generator = Random.new)
      self.generator = generator
      self.parts = []
      seed_flags
      prepare
    end

    def seed
      generator.seed
    end

    def to_s
      parts.map(&:to_s).join(' ')
    end

    def seed_flags
      self.flags = {
        tense: %i[tense_present tense_past][generator.rand(2)],
        number: %i[number_singular number_plural][generator.rand(2)]
      }
    end

    def prepare
      parts << SentenceMembers::Subject.new(generator, flags)
      parts << SentenceMembers::Predicate.new(generator, flags)
    end
  end
end
