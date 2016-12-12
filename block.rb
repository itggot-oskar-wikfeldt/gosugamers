require_relative './object.rb'
require_relative './world.rb'

class Block < Object
  def initialize(x, y, width, height, tex, collidable, draw)
    if tex == 'stone'
      if collidable
        tex = Gosu::Image.new('./res/stone.png', :tileable => true)
      else
        tex = Gosu::Image.new('./res/stone_inactive.png', :tileable => true)
      end

    elsif tex == 'grass'
      if collidable
        tex = Gosu::Image.new('./res/grass.png', :tileable => true)
      else
        tex = Gosu::Image.new('./res/grass_inactive.png', :tileable => true)
      end

    end
    if width < 0
      width*=-1
      x-=width
    end
    super(x, y, width, height, [tex], draw)
    $colliding << self if collidable

  end


  def draw
    @texture.draw(@x+$offsetX, @y+$offsetY, 0, scale_x = @width, scale_y = @height, color = 0xff_ffffff, mode = :default)
  end
  def update

  end
end