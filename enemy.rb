require_relative './entity.rb'
require_relative './game_window.rb'
class Enemy < Entity
  def initialize(x, y, target)
    super(x, y, Gosu::Image.new('./res/slime.png'), Gosu::Image.new('./res/slime.png'))
    @width = 48
    @height = 33
    @max_speed = 10
    @acceleration = 1
    #@touched_left_edge = true
    #@touched_right_edge = false
    @going_right = true
    @target = target
  end
  def update
    @accelX = 0

    if rand(100) == 1
      jump
      if @going_right
        @velX = 7
      else
        @velX = -7
      end

    end
=begin
    if @velX > 0 && (@bound_right > $window_width) && @touched_left_edge
      @going_right = false
      @touched_left_edge = false
      @touched_right_edge = true
    end
    if @velX < 0 && (@bound_left < 0) && @touched_right_edge
      @going_right = true
      @touched_left_edge = true
      @touched_right_edge = false
    end
=end
    if @x > @target.x && @collidingY
      @going_right = false
    else
      @going_right = true
    end

    super
  end
end