# frozen_string_literal: true

# Managing text corpora
class Admin::CorporaController < AdminController
  include ListAndShowEntities

  # get /admin/corpora/:id
  def show
    @collection = @entity.corpus_texts.page_for_administration(current_page)
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
