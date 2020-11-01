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

        # @param [String|nil] pattern
        def generate(pattern = nil)
          if pattern.nil?
            offset = @generator.rand(SentencePattern.count)
            pattern = SentencePattern.offset(offset).first&.pattern
          end
          result = pattern.to_s.gsub(PATTERN) { |chunk| process chunk }.strip
          result[0].upcase + result[1..]
        end

        private

        # @param [String] chunk
        def process(chunk)
          item = sample(chunk.gsub(/[\[\]]/, '').split('|')).split(':')
          type = @types[item[0]]
          type.nil? ? chunk : word(type, item[1].to_i).to_s
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
