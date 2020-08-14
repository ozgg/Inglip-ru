# frozen_string_literal: true

module Sentence
  # Simple bidding for testing vocabulary.
  class Bidding
    attr_accessor :generator, :flags, :subject, :apposition, :predicate

    # @param [Integer] seed
    def initialize(seed = nil)
      self.generator = Random.new(seed || Random.new_seed)
      init_flags
      self.subject = Noun.new(seed)
      self.predicate = Verb.new(seed)
    end

    # @return Integer
    def seed
      generator.seed
    end

    def to_s
      prepare
      parts = []
      if imperative?
        parts << predicate.to_s.capitalize
        parts << subject.to_s
      else
        parts << subject.to_s.capitalize
        parts << predicate.to_s
      end

      parts.join(' ')
    end

    def init_flags
      self.flags = {
        imperative: generator.rand(2) == 1,
        apposition: generator.rand(2) == 1,
        number: %i[number_singular number_plural][generator.rand(2)],
        tense: %i[tense_past tense_present][generator.rand(2)]
      }
    end

    def imperative?
      flags[:imperative]
    end

    def apposition?
      flags[:apposition]
    end

    def plural?
      flags[:number] == :number_plural
    end

    def present_tense?
      flags[:tense] == :tense_present
    end

    def prepare
      prepare_subject
      prepare_predicate
    end

    def prepare_predicate
      predicate.remove_flag :gerund
      if imperative?
        predicate.reset_flags
        predicate.add_flag :imperative
        flags[:number] = :number_singular
      else
        predicate.remove_flag :imperative
        predicate.person_flag = :person_third
        if predicate.perfective?
          predicate.tense_flag = :tense_past
          predicate.gender_flag = subject.gender_flag
        else
          predicate.tense_flag = flags[:tense]
          predicate.gender_flag = present_tense? ? nil : subject.gender_flag
        end
      end

      predicate.remove_flag :person_third if predicate.flag?(:tense_past)
      predicate.number_flag = flags[:number]
      predicate.gender_flag = nil if plural?
    end

    def prepare_subject
      subject.case_flag = :case_nominative unless imperative?
      subject.number_flag = flags[:number]
    end
  end
end
