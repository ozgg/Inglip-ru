module LexemesHelper
  # @param [LexemeType] entity
  def admin_lexeme_type_link(entity)
    link_to(entity.name, admin_lexeme_type_path(id: entity.id))
  end
end
