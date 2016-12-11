require_relative './entity.rb'
require_relative './world.rb'

class Block < Entity
  def initialize(x, y, width, height, tex, collidable)
    if tex == 'stone'
      tex = Gosu::Image.new('./res/pixel.png', :tileable => true)
    else
      tex = Gosu::Image.new('./res/pixel.png', :tileable => true)
    end



    super(x, y, [tex], true)
    @width = width
    @height = height
    $blocks << self if collidable
  end
  attr_accessor :x, :y, :width, :height

  def draw
    @texture.draw(@x, @y, 0, scale_x = @width, scale_y = @height, color = 0xff_ffffff, mode = :default)
  end
  def update

  end
end