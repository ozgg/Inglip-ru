class LexemesController < AdminController
  before_action :set_entity, only: %i[edit update destroy]

  # post /lexemes/check
  def check
    @entity = Lexeme.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # post /lexemes
  def create
    @entity = Lexeme.new(creation_parameters)
    if @entity.save
      save_with_handler
    else
      form_processed_with_error(:new)
    end
  end

  # get /lexemes/:id/edit
  def edit
  end

  # put /lexemes/:id
  def update
    if @entity.update(entity_parameters)
      flash[:notice] = t('lexemes.update.success')
      save_with_handler
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /lexemes/:id
  def destroy
    if @entity.destroy
      flash[:notice] = t('lexemes.destroy.success')
    end
    redirect_to(lexemes_admin_lexeme_type_path(id: @entity.lexeme_type_id))

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

  def entity_parameters
    params.require(:lexeme).permit(Lexeme.entity_parameters)
  end

  def creation_parameters
    params.require(:lexeme).permit(Lexeme.creation_parameters)
  end

  def save_with_handler
    handler = LexemeHandler.handler(@entity)
    handler.save(params[:lexeme_flags].permit!, params[:wordforms].permit!)
    form_processed_ok(admin_lexeme_path(id: @entity.id))
  end
end
