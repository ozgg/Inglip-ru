class HoroscopeController < ApplicationController
  # get /horoscope
  def index
  end

  # get /horoscope/:sign
  def view
    seed   = Time.new.strftime('%Y%m%d').to_i + params[:sign].to_i(26)
    speech = Speech.new(seed)

    @forecast = speech.passage
  end
end
