# frozen_string_literal: true

# Handling lexemes
class Admin::LexemesController < AdminController
  include ListAndShowEntities

  before_action :set_entity, except: :index

  # get /admin/lexemes
  def index
    @filters = params[:filters]&.permit!.to_h
    @collection = Lexeme.page_for_administration(current_page, @filters)
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end
end
