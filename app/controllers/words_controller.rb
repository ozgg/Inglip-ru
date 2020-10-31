# frozen_string_literal: true

# Updating and destroying words
class WordsController < AdminController
  before_action :set_entity, except: :check

  # post /words/check
  def check
    @entity = Word.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # get /words/:id/edit
  def edit
  end

  # patch /words/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_word_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /words/:id
  def destroy
    flash[:success] = t('.success') if @entity.destroy
    redirect_to admin_words_path
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end

  def set_entity
    @entity = Word.find_by(id: params[:id])
    handle_http_404('Cannot find word') if @entity.nil?
  end

  def entity_parameters
    params.require(:word).permit(Word.entity_parameters)
  end
end
