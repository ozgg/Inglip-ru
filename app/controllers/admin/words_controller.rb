# frozen_string_literal: true

# Viewing words
class Admin::WordsController < AdminController
  include CrudEntities

  before_action :set_entity, except: %i[check create index new]

  # get /admin/words
  def index
    @filters = params[:filters]&.permit!.to_h
    @collection = Word.page_for_administration(current_page, @filters)
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end
end
