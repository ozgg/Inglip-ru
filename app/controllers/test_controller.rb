class TestController < ApplicationController
  before_action :allow_authorized_only
  before_action :set_generator

  def subject
    render plain: Sentence::Subject.new(@generator).to_s + "\n#{@generator.seed}"
  end

  def apposition
    render plain: Sentence::Apposition.new(@generator).to_s + "\n#{@generator.seed}"
  end

  def gerund
    render plain: Sentence::Gerund.new(@generator).to_s + "\n#{@generator.seed}"
  end

  protected

  def set_generator
    if params[:seed] && params[:seed].match(/\A\d+\Z/)
      seed = params[:seed].to_i
    else
      seed = nil
    end

    @generator = Random.new(seed || Random.new_seed)
  end
end
