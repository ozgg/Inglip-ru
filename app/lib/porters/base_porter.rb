# frozen_string_literal: true

module Porters
  # Shared parts for porters
  class BasePorter
    # @param [Hash] data
    def parse(data)
      @data = data
      type = LexemeType[data['type']]
      @attributes = {
        lexeme_type: type,
        context: data['context'],
        body: data['infinitive']
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
      if @entity.valid?
        @handler.wordforms = wordforms
      else
        raise "Cannot save entity: #{@entity.errors}"
      end
    end
  end
end
