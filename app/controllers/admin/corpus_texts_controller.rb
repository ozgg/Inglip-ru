# frozen_string_literal: true

# Managing corpus text samples
class Admin::CorpusTextsController < AdminController
  include ListAndShowEntities
  include ToggleableEntity

  before_action :set_entity, except: :index

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
