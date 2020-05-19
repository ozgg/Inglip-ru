# frozen_string_literal: true

# Helpers for words component
module WordsHelper
  # @param [LexemeType] entity
  # @param [String] text
  # @param [Hash] options
  def admin_lexeme_type_link(entity, text = entity.name, options = {})
    link_to(text, admin_lexeme_type_path(id: entity.slug), options)
  end
end
