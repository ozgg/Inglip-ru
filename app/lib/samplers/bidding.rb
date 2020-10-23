# frozen_string_literal: true

module Samplers
  # Sample bidding
  class Bidding
    # @param [Random] generator
    def initialize(generator = nil)
      @generator = generator || Random.new
      @noun = Biovision::Components::Words::LexemeHandler[lexeme('noun')]
      @verb = Biovision::Components::Words::LexemeHandler[lexeme('verb')]
    end

    def to_s
      "#{@verb.decline(*verb_flags)} #{@noun.decline(*noun_flags)}"
    end

    private

    # @param [String] type
    def lexeme(type)
      list = LexemeType[type].lexemes
      list.offset(@generator.rand(list.count)).first
    end

    def verb_flags
      [
        :imperative,
        sample(%i[number_singular number_plural])
      ]
    end

    def noun_flags
      cases = [:case_dative]
      if @verb.passive?
        cases << :case_accusative
        cases << :case_instrumental
      end

      [
        sample(%i[number_singular number_plural]),
        sample(cases)
      ]
    end

    # @param [Array] set
    def sample(set)
      return if set.empty?

      set[@generator.rand(set.count)]
    end
  end
end
