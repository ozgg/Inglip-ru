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
      parts.map(&:to_s).join(' ').upcase_first
    end

    def seed_flags
      self.flags = {
        tense: sample(:tense_present, :tense_past),
        number: sample(:number_singular, :number_plural),
        use_gerund: sample(true, false),
        use_apposition: sample(true, false),
        use_adverb: sample(true, false)
      }
    end

    def prepare
      subject = SentenceMembers::Subject.new(generator, flags)
      predicate = SentenceMembers::Predicate.new(generator, flags)
      predicate.subject = subject
      if flags[:use_gerund]
        gerund = SentenceMembers::Gerund.new(generator, flags)
        parts << gerund.to_s + ','
      end
      parts << subject
      parts << predicate
      if flags[:use_apposition]
        apposition = SentenceMembers::Subject.new(generator)
        apposition.flags[:use_apposition] = false
        apposition.case_valency = [:case_instrumental] #predicate.case_valency
        parts << apposition.to_s
      end
    end

    # @param items
    def sample(*items)
      items[generator.rand(items.count)]
    end
  end
end
