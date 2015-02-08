class ApiController < ApplicationController
  before_action :set_speech

  # get /api/claim
  def claim
    render plain: "#{@speech.claim}\n#{@speech.seed}"
  end

  # get /api/tagline
  def tagline
    render plain: "#{@speech.tagline}\n#{@speech.seed}"
  end

  protected

  def set_speech
    if params[:seed] && params[:seed].match(/\A\d+\Z/)
      seed = params[:seed].to_i
    else
      seed = nil
    end

    @speech = Speech.new seed
  end
end
