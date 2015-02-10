class IndexController < ApplicationController
  def index
  end

  def about
  end

  def sentence
    if params[:seed] && params[:seed].match(/\A\d+\Z/)
      seed = params[:seed].to_i
    else
      seed = nil
    end

    speech = Speech.new seed

    @sentence = speech.sentence
    @seed = speech.seed
  end
end
