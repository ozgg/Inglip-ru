# frozen_string_literal: true
class SamplesController < ApplicationController
  before_action :init_generator

  # get /samples/text
  def text
  end

  # get /samples/bidding
  def bidding
    data = {
      id: @generator.seed,
      type: 'bidding',
      attributes: {
        text: Samplers::Bidding.new(@generator).to_s
      }
    }
    render json: { data: data }
  end

  # get /samples/analyze
  def analyze
  end

  private

  def init_generator
    seed = params.key?(:seed) ? params[:seed].to_i : nil
    @generator = seed.nil? ? Random.new : Random.new(seed)
  end
end
