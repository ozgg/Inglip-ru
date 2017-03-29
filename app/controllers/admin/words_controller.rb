class Admin::WordsController < ApplicationController
  before_action :set_entity, except: [:index]

  # get /admin/words
  def index
    @collection = Word.page_for_administration(current_page)
  end

  # get /admin/words/:id
  def show

  end

  private

  def set_entity
    @entity = Word.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find word')
    end
  end

  def restrict_access
    require_privilege :administrator
  end
end
