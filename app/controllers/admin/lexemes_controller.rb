# frozen_string_literal: true

# Handling lexemes
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

  def component_class
    Biovision::Components::WordsComponent
  end

  def set_entity
    @entity = Lexeme.find_by(id: params[:id])
    handle_http_404('Cannot find lexeme') if @entity.nil?
  end
end
