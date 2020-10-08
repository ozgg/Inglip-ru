# frozen_string_literal: true

# Managing pending words
class PendingWordsController < AdminController
  before_action :set_entity

  # delete /lexemes/:id
  def destroy
    flash[:success] = t('.success') if @entity.destroy
    redirect_to admin_pending_words_path
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end

  def set_entity
    @entity = PendingWord.find_by(id: params[:id])
    handle_http_404('Cannot find pending_word') if @entity.nil?
  end
end
