require_relative './mob.rb'
class Player < Mob
  def initialize(x, y)
    super(x, y, 42, 39, [Gosu::Image.new('./res/bunny_right.png'), Gosu::Image.new('./res/bunny_left.png')])

  end

  def update
    @accelX = 0
    if Gosu::button_down? Gosu::KbLeft
      move_left
      change_tex('left')
    end
    if Gosu::button_down? Gosu::KbRight
      move_right
      change_tex('right')
    end
    if Gosu::button_down? Gosu::KbSpace
      jump
    end

    if Gosu::button_down? Gosu::KbR
      @x = $window_width/2
      @y = 20
    end


    super
  end

end