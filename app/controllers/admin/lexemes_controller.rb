# frozen_string_literal: true

# Handling lexemes
class Admin::LexemesController < AdminController
  include CrudEntities

  before_action :set_entity, except: %i[check create index new]
  before_action :set_handler, except: %i[check create index new]

  # get /admin/lexemes
  def index
    @filters = params[:filters]&.permit!.to_h
    @collection = Lexeme.page_for_administration(current_page, @filters)
  end

  # post /admin/lexemes
  def create
    type = LexemeType.find(params.dig(:lexeme, :lexeme_type_id))
    handler = Biovision::Components::Words::LexemeHandler.for_type(type)
    @entity = handler.create(creation_parameters, lexeme_data)
    if @entity.valid?
      handler.wordforms = wordforms
      form_processed_ok(admin_lexeme_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # patch /admin/lexemes/:id
  def update
    if @handler.update(entity_parameters, lexeme_data)
      @handler.wordforms = wordforms
      form_processed_ok(admin_lexeme_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end

  def set_handler
    @handler = Biovision::Components::Words::LexemeHandler[@entity]
  end

  def lexeme_data
    params.require(:lexeme_data).permit!
  end

  def wordforms
    params.key?(:wordforms) ? params[:wordforms].permit! : {}
  end
end
