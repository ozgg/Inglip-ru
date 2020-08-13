# frozen_string_literal: true

module Sentence
  # Setting wordform flags for sentence member
  module WordformFlags
    # @param [Symbol] new_flag
    def case_flag=(new_flag)
      @flags -= handler.class.case_flags.keys
      @flags -= handler.class.noun_case_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def case_flag
      regular_cases = handler.class.case_flags.keys
      noun_cases = handler.class.noun_case_flags.keys
      (@flags & regular_cases & noun_cases).first
    end

    # @param [Symbol] new_flag
    def number_flag=(new_flag)
      @flags -= handler.class.number_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def number_flag
      (@flags & handler.class.number_flags.keys).first
    end

    def plural?
      number_flag == :number_plural
    end

    # @param [Symbol] new_flag
    def gender_flag=(new_flag)
      @flags -= handler.class.gender_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def gender_flag
      (@flags & handler.class.gender_flags.keys).first
    end

    # @param [Symbol] new_flag
    def tense_flag=(new_flag)
      @flags -= handler.class.tense_flags.keys
      @flags << new_flag unless new_flag.nil?
    end

    def tense_flag
      (@flags & handler.class.tense_flags.keys).first
    end
  end
end
