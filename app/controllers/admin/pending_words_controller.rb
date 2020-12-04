# frozen_string_literal: true

# Managing pending words
class Admin::PendingWordsController < AdminController
  include CrudEntities

  before_action :set_entity, except: %i[check create index new]

  # get /admin/pending_words
  def index
    @collection = PendingWord.page_for_administration(current_page)
  end

  # delete /lexemes/:id
  def destroy
    flash[:success] = t('.success') if @entity.destroy
    redirect_to admin_pending_words_path
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
