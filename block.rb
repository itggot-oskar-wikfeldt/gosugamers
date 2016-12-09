require_relative './entity.rb'
require_relative './world.rb'
require 'gosu'
class Block < Entity
  def initialize(x, y, width, height, tex)
    super(x, y, tex, tex)
    @width = width
    @height = height
    $blocks << self
    @static = true
  end
  attr_accessor :x, :y

  def draw
    @texture.draw(@x, @y, 0, scale_x = @width, scale_y = @height, color = 0xff_ffffff, mode = :default)
  end
end