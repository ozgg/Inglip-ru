# frozen_string_literal: true

# Managing corpus text samples
class Admin::CorpusTextsController < AdminController

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
