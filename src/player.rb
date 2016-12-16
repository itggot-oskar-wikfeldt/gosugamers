require_relative 'mob'
require 'gosu'
class Player < Mob
  include Gosu
  def initialize(x, y, binds, gamepad)
    super(x, y, 42, 39, { right => Image.new('../res/bunny_right.png'), left => Image.new('../res/bunny_left.png')], weapon => Image.new('../res/carrot.png', :retro => true)})
    @left_bind = binds[0]
    @right_bind = binds[1]
    @jump_bind = binds[2]
    @attack_bind = binds[3]
    @jump_pressed = false
    @attacking = false
    @gamepad = gamepad
    @attack_time

  end

  def update
    @accelX = 0
    if (button_down? @left_bind) || (@gamepad && (button_down? GpLeft))
      move_left
    end
    if (button_down? @right_bind) || (@gamepad && (button_down? GpRight))
      move_right
    end
    if (button_down? @jump_bind) || (@gamepad && (button_down? GpButton0))
      if !@jump_pressed
        jump
      end
      @jump_pressed = true
    else
      @jump_pressed = false
    end


    if button_down? KbR
      @x = 0
      @y = -300
      @velY = 0
    end

    if ((button_down? @attack_bind) || (@gamepad && (button_down? GpButton2)))
      if !@attacked
        @attacking = true
      else
        @attacking = false
      end

      @attacked = true
    else
      @attacking = false
      @attacked = false
    end






    super

  end


end