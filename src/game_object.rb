require_relative './camera.rb'
class GameObject
  def initialize(x, y, width, height, textures, draw)
    @texture = textures[0]
    @textures = textures
    @bound_left = @bound_right = @bound_top = @bound_bottom = 0
    @width = width
    @height = height
    @x = x
    @y = y
    $objects << self if draw

  end
  attr_accessor :x, :y, :width, :height
  def get_bound(bound)
    if bound == 'left'
      return @x
    elsif bound == 'right'
      return @x+@width
    elsif bound == 'top'
      return @y
    elsif bound == 'bottom'
      return @y + @height
    else
      puts "invalid bound"
    end

  end
  def draw
    @texture.draw(@x+$offsetX, @y+$offsetY, 0)
  end
end