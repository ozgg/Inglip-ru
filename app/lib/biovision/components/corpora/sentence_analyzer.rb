# frozen_string_literal: true

module Biovision
  module Components
    module Corpora
      # Analyzing sentence patterns
      class SentenceAnalyzer
        # @param [String] text
        def analyze(text)
          text.strip.gsub(/([.?!]+)/, "\\1\t").split("\t").map do |sample|
            analyze_sentence(sample.strip)
          end
        end

        private

        # @param [String] sample
        def analyze_sentence(sample)
          {
            sample: sample,
            pattern: parse(sample)
          }
        end

        # @param [String] sample
        def parse(sample)
          parts = []
          sample.downcase.split(/[^-а-яё,()—.?!]/i).each do |chunk|
            group = []
            chunk.gsub(/([^-а-яё]+)/, "\t\\1\t").split("\t").each do |word|
              group << (word.match?(/[-а-яё]+/) ? analyze_word(word) : word)
            end
            parts << group.join
          end
          parts.join(' ')
        end

        def analyze_word(text)
          word = Word.find_by(body: text)
          word.nil? ? text : wordforms(word)
        end

        def wordforms(word)
          list = Wordform.where(word: word).map do |wordform|
            "#{wordform.lexeme.lexeme_type.slug}:#{wordform.flags}"
          end
          "[#{list.join('|')}]"
        end
      end
    end
  end
end