# frozen_string_literal: true

# Managing corpus text samples
class CorpusTextsController < AdminController
  include CreateAndModifyEntities

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
