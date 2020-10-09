# frozen_string_literal: true

# Managing corpus text samples
class CorpusTextsController < AdminController
  include CreateAndModifyEntities

  before_action :set_entity, except: %i[check create new]

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
