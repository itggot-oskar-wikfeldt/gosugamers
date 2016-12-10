require_relative './entity.rb'
class Enemy < Entity
  def initialize(x, y, target)
    super(x, y, Gosu::Image.new('./res/slime.png'), Gosu::Image.new('./res/slime.png'), false)
    @width = 48
    @height = 33
    @max_speed = 10
    @acceleration = 1



  end
  def update



  end
end