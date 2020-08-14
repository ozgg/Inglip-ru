# frozen_string_literal: true

module Sentence
  # Verb in sentence
  class Verb < SentenceMember
    def random_lexeme
      list = LexemeType['verb'].lexemes
      list.offset(generator.rand(list.count)).first
    end

    # @param [Array] permitted
    def randomize_flags(permitted = handler.class.wordform_flags.keys)
      randomize_tense(permitted)
      randomize_number(permitted)
      randomize_person(permitted)
      randomize_form(permitted)
      check_flags
    end

    # @param [Array] permitted
    def randomize_tense(permitted)
      self.tense_flag = sample(handler.class.tense_flags.keys & permitted)
    end

    # @param [Array] permitted
    def randomize_number(permitted)
      self.number_flag = sample(handler.class.number_flags.keys & permitted)
    end

    # @param [Array] permitted
    def randomize_person(permitted)
      self.person_flag = sample(handler.class.person_flags.keys & permitted)
    end

    # @param [Array] permitted
    def randomize_form(permitted)
      self.form_flag = sample(handler.class.verb_form_flags.keys & permitted)
    end

    def check_flags
      check_gerund
      check_tense
      check_imperative
    end

    # @param [Symbol] new_flag
    def person_flag=(new_flag)
      @flags -= handler.class.person_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def person_flag
      (@flags & handler.class.person_flags.keys).first
    end

    # @param [Symbol] new_flag
    def form_flag=(new_flag)
      @flags -= handler.class.verb_form_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def form_flag
      (@flags & handler.class.verb_form_flags.keys).first
    end

    def perfective?
      handler.perfective?
    end

    private

    def check_imperative
      return unless handler.lexeme.flag?(:imperative)

      self.tense_flag = nil
      self.person_flag = nil
    end

    def check_tense
      return unless handler.perfective? || tense_flag == :tense_present

      self.tense_flag = :tense_past
    end

    def check_gerund
      return unless handler.lexeme.flag?(:gerund)

      self.number_flag = nil
      self.person_flag = nil
      self.tense_flag = nil
    end
  end
end
