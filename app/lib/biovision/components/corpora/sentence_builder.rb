# frozen_string_literal: true

module Biovision
  module Components
    module Corpora
      # Build sentences using patterns
      class SentenceBuilder
        PATTERN = /\[[^\]]+\]/.freeze

        attr_accessor :corpus, :generator

        # @param [Random] generator
        def initialize(generator = nil)
          self.generator = generator || Random.new
          @types = LexemeType.order('id asc').pluck(:slug, :id).to_h
        end

        def to_s
          generate
        end

        def generate
          offset = @generator.rand(SentencePattern.count)
          @sentence = SentencePattern.offset(offset).first
          @sentence.pattern.gsub(PATTERN) do |chunk|
            process PATTERN.match(chunk)
          end
        end

        private

        def process(match)
          item = sample(match.to_s.gsub('[', '').gsub(']', '').split('|')).split(':')
          type = @types[item[0]]
          if type.nil?
            match.to_s
          else
            word(type, item[1].to_i).to_s
          end
        end

        def word(lexeme_type, flags)
          join_clause = { lexemes: { lexeme_type_id: lexeme_type } }
          list = Wordform.joins(:lexeme).where(join_clause).where(flags: flags)
          list.offset(@generator.rand(list.count)).first&.text
        end

        # @param [Array] set
        def sample(set)
          return if set.empty?

          set[@generator.rand(set.count)]
        end
      end
    end
  end
end