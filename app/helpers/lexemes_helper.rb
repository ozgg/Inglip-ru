module LexemesHelper
  # @param [LexemeType] entity
  def admin_lexeme_type_link(entity)
    link_to(entity.name, admin_lexeme_type_path(id: entity.slug))
  end

  # @param [Lexeme] entity
  def admin_lexeme_link(entity)
    link_to(entity.body, admin_lexeme_path(id: entity.id))
  end
end
