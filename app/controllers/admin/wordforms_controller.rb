# frozen_string_literal: true

# Handling wordforms
class Admin::WordformsController < AdminController
  before_action :set_entity, except: :index

  # get /admin/wordforms
  def index
    @collection = Wordform.page_for_administration(current_page)
  end

  # get /admin/wordforms/:id
  def show
  end

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

  def set_entity
    @entity = Wordform.find_by(id: params[:id])
    handle_http_404('Cannot find wordform') if @entity.nil?
  end
end
