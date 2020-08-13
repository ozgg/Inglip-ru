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
      # tense_flags, number_flags, person_flags, verb_form_flags
      randomize_tense(permitted)
      randomize_number(permitted)
      randomize_person(permitted)
      randomize_form(permitted)
      check_flags
    end

    # @param [Array] permitted
    def randomize_tense(permitted)
      set = permitted & handler.class.tense_flags.keys
      self.tense_flag = sample(set)
    end

    # @param [Array] permitted
    def randomize_person(permitted)
      set = permitted & handler.class.person_flags.keys
      self.person_flag = sample(set)
    end

    # @param [Array] permitted
    def randomize_form(permitted)
      set = permitted & handler.class.verb_form_flags.keys
      self.form_flag = sample(set)
    end

    def check_flags
      if handler.lexeme.flag?(:gerund)
        self.number_flag = nil
        self.person_flag = nil
        self.tense_flag = nil
      end
      if handler.perfective? && tense_flag == :tense_present
        self.tense_flag = :tense_past
      end
      if handler.lexeme.flag?(:imperative)
        self.tense_flag = nil
        self.person_flag = nil
      end
    end

    # @param [Symbol] new_flag
    def tense_flag=(new_flag)
      @flags -= handler.class.tense_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def tense_flag
      (@flags & handler.class.tense_flags.keys).first
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
  end
end
