# frozen_string_literal: true

module Sentence
  # Preposition in sentence
  class Preposition < SentenceMember
    def random_lexeme
      list = LexemeType['preposition'].lexemes
      list.offset(generator.rand(list.count)).first
    end
  end
end
