class DreambookController < ApplicationController
  def index
    @letter = params[:letter].to_s.encode('UTF-8', 'UTF-8', invalid: :replace, replace: '')
    process_letter if @letter.length > 0
  end

  def show
    @dream = Dream.find_by name: params[:name]
    redirect_to dreambook_search_path(query: params[:name]) if @dream.nil?
  end

  def search
    @query = params[:query].to_s.encode('UTF-8', 'UTF-8', invalid: :replace, replace: '')
    dream = Dream.find_by name: @query
    redirect_to dreambook_path(name: @query) unless dream.nil?
  end

  protected

  def process_letter
    @dreams = Dream.where("name ilike ?", "#{@letter[0]}%").order('name asc').page(current_page).per(20)
  end
end
