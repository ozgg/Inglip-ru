# frozen_string_literal: true

# Managing text corpora
class CorporaController < AdminController
  include CreateAndModifyEntities

  before_action :set_entity, except: %i[check create new]

  def creation_parameters
    super.merge(owner_for_entity)
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
