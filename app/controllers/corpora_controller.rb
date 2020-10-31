# frozen_string_literal: true

# Managing text corpora
class CorporaController < AdminController
  include CreateAndModifyEntities

  def creation_parameters
    super.merge(owner_for_entity)
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
