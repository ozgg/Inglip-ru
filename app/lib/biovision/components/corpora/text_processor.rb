# frozen_string_literal: true

module Biovision
  module Components
    module Corpora
      # Processing corpus texts
      class TextProcessor
        attr_accessor :entity

        # @param [CorpusText] entity
        def initialize(entity)
          self.entity = entity
        end

        def process
          entity.body.split(/\s+/).each do |chunk|
            body = chunk.downcase.gsub(/[^-а-яё]/, '')

            next if body.blank?

            find_word(body)
          end
        end

        private

        # @param [String] body
        def find_word(body)
          word = Word.find_by(body: body)
          if word.nil?
            add_pending_word(body)
          else
            link_word(word)
          end
        end

        # @param [Word] word
        def link_word(word)
          entity << word
          word.lexemes.each { |lexeme| entity << lexeme }
        end

        # @param [String] body
        def add_pending_word(body)
          pending_word = PendingWord[body]
          pending_word.increment! :weight
          entity << pending_word
        end
      end
    end
  end
end
