# frozen_string_literal: true

# Viewing words
class Admin::WordsController < AdminController
  include ListAndShowEntities

  before_action :set_entity, except: :index

  private

  def component_class
    Biovision::Components::WordsComponent
  end
end
