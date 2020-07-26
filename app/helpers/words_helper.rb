# frozen_string_literal: true

# Helpers for words component
module WordsHelper
  # @param [LexemeType] entity
  # @param [String] text
  # @param [Hash] options
  def admin_lexeme_type_link(entity, text = entity.name, options = {})
    link_to(text, admin_lexeme_type_path(id: entity.slug), options)
  end

  # @param [Lexeme] entity
  # @param [String] text
  # @param [Hash] options
  def admin_lexeme_link(entity, text = entity.body, options = {})
    link_to(text, admin_lexeme_path(id: entity.id), options)
  end

  # @param [Wordform] entity
  # @param [String] text
  # @param [Hash] options
  def admin_wordform_link(entity, text = entity.text, options = {})
    link_to(text, admin_wordform_path(id: entity.id), options)
  end
end
