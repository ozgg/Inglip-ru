# frozen_string_literal: true

# Handling lexeme types
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

  # get /admin/lexeme_types/:id/new_lexeme
  def new_lexeme
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end

  def set_entity
    @entity = LexemeType[params[:id]]
    handle_http_404('Cannot find lexeme type') if @entity.nil?
  end
end
