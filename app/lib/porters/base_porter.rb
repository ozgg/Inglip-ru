# frozen_string_literal: true

module Porters
  # Shared parts for porters
  class BasePorter
    # @param [String] type
    def self.[](type)
      "porters/#{type}_porter".classify.constantize.new
    end

    # @param [Hash] data
    def parse(data)
      @data = data
      type = LexemeType[data['type']]
      @attributes = {
        lexeme_type: type,
        context: data['context'],
        body: data['infinitive'].gsub(/[^-а-яё]/, '')
      }
      return if Lexeme.exists?(@attributes)

      @handler = Biovision::Components::Words::LexemeHandler.for_type(type)
      handle
    end

    def lexeme_data
      {}
    end

    def wordforms
      {}
    end

    protected

    def handle
      @entity = @handler.create(@attributes, lexeme_data)
      raise "Cannot save entity: #{@entity.errors}" unless @entity.valid?

      @handler.wordforms = wordforms
    end
  end
end
