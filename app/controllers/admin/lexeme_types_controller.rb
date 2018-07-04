class Admin::LexemeTypesController < AdminController
  before_action :set_entity, except: :index

  # get /admin/lexeme_types
  def index
    @collection = LexemeType.list_for_administration
  end

  # get /admin/lexeme_types/:id
  def show
    @collection = @entity.lexemes.page_for_administration(current_page)
  end

  private

  def restrict_access
    require_privilege :word_manager
  end

  def set_entity
    @entity = LexemeType.find_by(slug: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find lexeme_type')
    end
  end
end
