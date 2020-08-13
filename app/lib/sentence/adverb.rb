# frozen_string_literal: true

module Sentence
  # Adverb in sentence
  class Adverb < SentenceMember
    def random_lexeme
      list = LexemeType['adverb'].lexemes
      list.offset(generator.rand(list.count)).first
    end
  end
end
