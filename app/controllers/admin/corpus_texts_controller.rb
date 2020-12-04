# frozen_string_literal: true

# Managing corpus text samples
class Admin::CorpusTextsController < AdminController
  include CrudEntities
  include ToggleableEntity

  before_action :set_entity, except: %i[check create index new]

  # get /admin/corpus_texts/:id/lexemes
  def lexemes
    @collection = @entity.lexemes.page_for_administration(current_page)
  end

  # get /admin/corpus_texts/:id/words
  def words
    @collection = @entity.words.page_for_administration(current_page)
  end

  # get /admin/corpus_texts/:id/pending_words
  def pending_words
    @collection = @entity.pending_words.page_for_administration(current_page)
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
