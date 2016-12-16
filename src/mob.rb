require_relative 'entity'
class Mob < Entity
  def initialize(x, y, width, height, tex)
    super(x, y, width, height, tex, true)

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
  end

  def attack
    
  end

  def draw
    super unless @dead
  end
end