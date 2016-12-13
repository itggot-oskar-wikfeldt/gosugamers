require_relative 'mob'
class Player < Mob
  def initialize(x, y, left_bind, right_bind, jump_bind)
    super(x, y, 42, 39, [Gosu::Image.new('../res/bunny_right.png'), Gosu::Image.new('../res/bunny_left.png')])
    @left_bind = left_bind
    @right_bind = right_bind
    @jump_bind = jump_bind
    @jump_pressed = false

  end

  def update
    @accelX = 0
    if Gosu::button_down? @left_bind
      move_left
      change_tex('left')
    end
    if Gosu::button_down? @right_bind
      move_right
      change_tex('right')
    end
    if (Gosu::button_down? @jump_bind)
      if !@jump_pressed
        jump
      end

      @jump_pressed = true
    else
      @jump_pressed = false
    end


    if Gosu::button_down? Gosu::KbR
      @x = 0
      @y = -300
      @velY = 0
    end


    super

  end

end