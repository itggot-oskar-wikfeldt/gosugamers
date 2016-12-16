require_relative 'mob'
class Player < Mob
  def initialize(x, y, binds, gamepad)
    super(x, y, 42, 39, [Gosu::Image.new('../res/bunny_right.png'), Gosu::Image.new('../res/bunny_left.png')])
    @left_bind = binds[0]
    @right_bind = binds[1]
    @jump_bind = binds[2]
    @attack_bind = binds[3]
    @jump_pressed = false
    @carrot = Gosu::Image.new('../res/carrot.png', :retro => true)
    @attacking = false
    @carrot_scale = 1
    @gamepad = gamepad
    @attack_time

  end

  def update
    @accelX = 0
    if (Gosu::button_down? @left_bind) || (@gamepad && (Gosu::button_down? Gosu::GpLeft))
      move_left
      @direction = 'left'
    end
    if (Gosu::button_down? @right_bind) || (@gamepad && (Gosu::button_down? Gosu::GpRight))
      move_right
      @direction = 'right'
    end
    if (Gosu::button_down? @jump_bind) || (@gamepad && (Gosu::button_down? Gosu::GpButton0))
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
    #p (@gamepad && (Gosu::button_down? Gosu::GpButton2))

    #if (Gosu::button_down? @attack_bind) || (@gamepad && (Gosu::button_down? Gosu::GpButton2))
    #  if !@attacking
    #    @attack_time = $timepassed
    #  end
    #  @attacking = true
    #end
#
    #if !((Gosu::button_down? @attack_bind) || (@gamepad && (Gosu::button_down? Gosu::GpButton2))) || $timepassed-@attack_time > 0.2
    #  @attacking = false
    #  @attack_time = 0
    #end
    #p @attacking

    if ((Gosu::button_down? @attack_bind) || (@gamepad && (Gosu::button_down? Gosu::GpButton2)))
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



    if @direction == 'left'
      change_tex('left')
      @carrot_scale = -1
    end
    if @direction == 'right'
      change_tex('right')
      @carrot_scale = 1
    end


    super

  end

  def draw
    super
    if @attacking
      @carrot.draw(@x+$offsetX+@width/2, @y+$offsetY+(@height/2-@carrot.height/2*0+2), 0, @carrot_scale*3, 1*3)
    end
  end

end