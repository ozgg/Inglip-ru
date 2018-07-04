class Admin::LexemesController < AdminController
  before_action :set_entity, except: :index

  # get /admin/lexemes
  def index
    @collection = Lexeme.page_for_administration(current_page)
  end

  # get /admin/lexemes/:id
  def show
  end

  private

  def restrict_access
    require_privilege :word_manager
  end

  def set_entity
    @entity = Lexeme.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find lexeme')
    end
  end
end
