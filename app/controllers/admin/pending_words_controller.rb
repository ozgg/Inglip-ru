# frozen_string_literal: true

# Managing pending words
class Admin::PendingWordsController < AdminController
  # get /admin/pending_words
  def index
    @collection = PendingWord.page_for_administration(current_page)
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
