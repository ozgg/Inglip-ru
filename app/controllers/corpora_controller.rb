# frozen_string_literal: true

# Managing text corpora
class CorporaController < AdminController

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
