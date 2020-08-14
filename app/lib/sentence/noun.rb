# frozen_string_literal: true

module Sentence
  # Noun in sentence
  class Noun < SentenceMember
    def random_lexeme
      list = LexemeType['noun'].lexemes
      list.offset(generator.rand(list.count)).first
    end

    # @param [Array] permitted
    def randomize_flags(permitted = handler.class.wordform_flags.keys)
      if handler.lexeme.declinable?
        randomize_case(permitted)
        randomize_number(permitted)
      else
        self.flags = [:infinitive]
      end
    end

    # @param [Array] permitted
    def randomize_case(permitted)
      set = handler.class.case_flags.keys
      set << :case_locative if handler.locative?
      set << :case_pertitive if handler.partitive?
      set << :case_vocative if handler.vocative?
      set &= permitted
      self.case_flag = sample(set)
    end

    # @param [Array] permitted
    def randomize_number(permitted)
      if handler.lexeme.flag?(:singular_only)
        self.number_flag = :number_singular
      elsif handler.lexeme.flag?(:plural_only)
        self.number_flag = :number_plural
      else
        set = handler.class.number_flags.keys & permitted
        self.number_flag = sample(set)
      end
    end

    def gender_flag
      mapping = {
        0 => :gender_feminine,
        1 => :gender_masculine,
        2 => :gender_neuter,
      }

      mapping[handler.lexeme.data['gender']]
    end
  end
end
