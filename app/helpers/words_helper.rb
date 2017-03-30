module WordsHelper
  # @param [LexemeGroup] entity
  def admin_lexeme_group_link(entity)
    link_to(entity.name, admin_lexeme_group_path(entity.id))
  end

  # @param [Lexeme] entity
  def admin_lexeme_link(entity)
    link_to(entity.name, admin_lexeme_path(entity.id))
  end

  # @param [Word] entity
  def admin_word_link(entity)
    link_to(entity.name, admin_word_path(entity.id))
  end
end
