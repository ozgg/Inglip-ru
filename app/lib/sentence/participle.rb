# frozen_string_literal: true

module Sentence
  # Participle in sentence
  class Participle < SentenceMember
    def random_lexeme
      list = LexemeType['participle'].lexemes
      list.offset(generator.rand(list.count)).first
    end

    # @param [Array] permitted
    def randomize_flags(permitted = handler.class.wordform_flags.keys)
      randomize_case(permitted)
      randomize_number(permitted)
      randomize_gender(permitted)
      randomize_tense(permitted)
      check_flags
    end

    def check_flags
      self.gender_flag = nil if number_flag == :number_plural
    end

    # @param [Array] permitted
    def randomize_case(permitted)
      self.case_flag = sample(handler.class.case_flags.keys & permitted)
    end

    # @param [Array] permitted
    def randomize_number(permitted)
      self.number_flag = sample(handler.class.number_flags.keys & permitted)
    end

    # @param [Array] permitted
    def randomize_gender(permitted)
      self.number_flag = sample(handler.class.gender_flags.keys & permitted)
    end

    # @param [Array] permitted
    def randomize_tense(permitted)
      self.tense_flag = sample(handler.class.tense_flags.keys & permitted)
    end
  end
end
