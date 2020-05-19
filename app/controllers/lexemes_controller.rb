# frozen_string_literal: true

# Handling lexemes
class LexemesController < AdminController
  before_action :set_entity, except: :create
  before_action :set_handler, except: :create

  # post /lexemes
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

  # get /lexemes/:id/edit
  def edit
  end

  # patch /lexemes/:id
  def update
    if @handler.update(entity_parameters, lexeme_data)
      @handler.wordforms = wordforms
      form_processed_ok(admin_lexeme_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /lexemes/:id
  def destroy
    flash[:success] = t('.success') if @entity.destroy
    redirect_to admin_lexemes_path
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end

  def set_entity
    @entity = Lexeme.find_by(id: params[:id])
    handle_http_404('Cannot find lexeme') if @entity.nil?
  end

  def set_handler
    @handler = Biovision::Components::Words::LexemeHandler[@entity]
  end

  def entity_parameters
    params.require(:lexeme).permit(Lexeme.entity_parameters)
  end

  def creation_parameters
    params.require(:lexeme).permit(Lexeme.creation_parameters)
  end

  def lexeme_data
    params.require(:lexeme_data).permit!
  end

  def wordforms
    params.key?(:wordforms) ? params[:wordforms].permit! : {}
  end
end
