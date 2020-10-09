# frozen_string_literal: true

# Handling lexemes
class Admin::LexemesController < AdminController
  include ListAndShowEntities

  before_action :set_entity, except: :index

  private

  def component_class
    Biovision::Components::WordsComponent
  end
end
