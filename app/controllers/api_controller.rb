# frozen_string_literal: true

# API methods
class ApiController < ApplicationController
  # get /api/normalize/:word
  def normalize
    entity = Word.find_by(body: params[:word].downcase)
    if entity.nil?
      handle_http_404(%(Cannot find word "#{params[:word]}"))
    else
      @collection = entity.lexemes.list_for_visitors
    end
  end
end
