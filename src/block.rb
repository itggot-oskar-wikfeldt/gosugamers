require_relative './game_object.rb'
require_relative './world.rb'

class Block < GameObject
  def initialize(x, y, width, height, tex, collidable, draw)
    if tex == 'stone'
      if collidable
        tex = Gosu::Image.new('../res/stone.png', :tileable => true)
      else
        tex = Gosu::Image.new('../res/stone_inactive.png', :tileable => true)
      end

    elsif tex == 'grass'
      if collidable
        tex = Gosu::Image.new('../res/grass.png', :tileable => true)
      else
        tex = Gosu::Image.new('../res/grass_inactive.png', :tileable => true)
      end

    end
    if width < 0
      width*=-1
      x-=width
    end

    if height < 0
      height*=-1
      y-=height
    end

    super(x, y, width, height, [tex], draw)
    $colliding << self if collidable

  end


  def draw
    @texture.draw(@x+$offsetX, @y+$offsetY, 0, @width, @height, 0xff_ffffff, :default)
  end
  def update

  end
end