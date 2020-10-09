# frozen_string_literal: true

# Handling wordforms
class Admin::WordformsController < AdminController
  include ListAndShowEntities

  before_action :set_entity, except: :index

  # put /admin/wordforms/:id/flags/:flag
  def add_flag
    @entity.add_flag!(params[:flag].to_i)

    render json: { meta: { flag: @entity.flags.to_s(2).rjust(32, '0') } }
  end

  # delete /admin/wordforms/:id/flags/:flag
  def remove_flag
    @entity.remove_flag!(params[:flag].to_i)

    render json: { meta: { flag: @entity.flags.to_s(2).rjust(32, '0') } }
  end

  private

  def component_class
    Biovision::Components::WordsComponent
  end
end
