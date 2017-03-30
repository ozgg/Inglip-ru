class Admin::LexemeGroupsController < AdminController
  before_action :set_entity, except: [:index]

  # get /admin/lexeme_groups
  def index
    @collection = LexemeGroup.page_for_administration
  end

  # get /admin/lexeme_groups/:id
  def show
  end

  # get /admin/lexeme_groups/:id/lexemes
  def lexemes
    @collection = @entity.lexemes.page_for_administration(current_page)
  end

  private

  def set_entity
    @entity = LexemeGroup.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find lexeme group')
    end
  end

  def restrict_access
    require_privilege :administrator
  end
end
