require_relative './object.rb'
require_relative './world.rb'

class Block < Object
  def initialize(x, y, width, height, tex, collidable)
    if tex == 'stone'
      tex = Gosu::Image.new('./res/pixel.png', :tileable => true)
    else
      tex = Gosu::Image.new('./res/pixel.png', :tileable => true)
    end

    super(x, y, width, height, [tex])
    $objects << self if collidable
  end


  def draw
    @texture.draw(@x, @y, 0, scale_x = @width, scale_y = @height, color = 0xff_ffffff, mode = :default)
  end
  def update

  end
end