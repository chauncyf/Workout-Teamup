require 'mini_magick'
module PhotosHelper
  def get_round_avatar_converter
    MiniMagick::Tool::Convert.new do |cvrt|
      cvrt.size '300x300'
      cvrt << 'xc:transparent'
      cvrt.fill 'image.png'
      cvrt.draw "circle 240,90 290,90"
      cvrt.crop '100x100+190+40'
      cvrt.repage.+
      cvrt << 'circle.png'
    end
  end
end
