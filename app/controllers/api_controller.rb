class ApiController < ApplicationController
  # get /api/claim
  def claim
    render plain: Speech.new.claim
  end

  # get /api/tagline
  def tagline
    render plain: Speech.new.claim
  end
end
