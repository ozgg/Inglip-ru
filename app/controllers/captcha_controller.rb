class CaptchaController < ApplicationController
  include Magick

  def index
    img = ImageList.new('public/images/captcha_back.png')
    txt = Draw.new
    txt.font = "#{Rails.root}/lib/fonts/pt-serif.ttf"
    img.annotate(txt, 312, 50, 0, 0, 'summoning Inglip') do
      txt.gravity = Magick::SouthGravity
      txt.pointsize = 25
      txt.stroke = '#000000'
      txt.fill = '#ffffff'
      txt.font_weight = Magick::BoldWeight
    end

    img.format = 'png'
    send_data img.to_blob, :stream => true, :type => 'image/png', :disposition => 'inline'
  end
end
