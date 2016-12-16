require_relative 'entity'
class Mob < Entity
  def initialize(x, y, width, height, tex)
    super(x, y, width, height, tex, true)
    @weapon = weapon
    @dead = false
    @attack_time
    $colliding << self

  end
  def kill
    $colliding.delete(self)
    @dead = true
  end
  def jump
    if @on_ground
      @velY = -12
    end
  end

  def move_left
    if @on_ground
      _acceleration = @acceleration
    else
      _acceleration = @air_acceleration
    end
    @accelX = -_acceleration

    if @velX <= 0 && @velX >=-1
      @velX = -1
    end
    @direction = 'left'

  end
  def move_right
    if @on_ground
      _acceleration = @acceleration
    else
      _acceleration = @air_acceleration
    end
    @accelX = _acceleration
    if @velX >= 0 && @velX <=1
      @velX = 1
    end
    @direction = 'right'
  end

  def attack
    @attack_time = $timepassed

  end

  def update
    if @direction == 'left'
      change_tex('left')
      @weapon = -1
    end
    if @direction == 'right'
      change_tex('right')
      @weapon = 1
    end
    super
  end

  def draw
    unless @dead
      super
      if @attacking
        @weapon.draw(@x+$offsetX+@width/2, @y+$offsetY+(@height/2-@carrot.height/2*0+2), 0, @carrot_scale*3, 1*3)
      end


    end

  end
end