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

        def generate(sentence = nil)
          @first_word = true
          if sentence.nil?
            offset = @generator.rand(SentencePattern.count)
            sentence = SentencePattern.offset(offset).first
          end
          sentence.pattern.gsub(PATTERN) do |chunk|
            word = process PATTERN.match(chunk)
            if @first_word
              @first_word = false
              word[0].upcase + word[1..]
            else
              word
            end
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

        # @param [Integer] lexeme_type
        # @param [Integer] flags
        def word(lexeme_type, flags)
          list = Wordform.where(flags: flags, lexeme_type_id: lexeme_type)
          offset = @generator.rand(list.count)
          query = "
            select body from words where id = (
              select word_id from wordforms where
                flags = #{flags.to_i} and lexeme_type_id = #{lexeme_type.to_i}
              limit 1 offset #{offset}
            )"
          Word.connection.execute(query).first['body']
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