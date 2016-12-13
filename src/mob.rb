require_relative 'entity'
class Mob < Entity
  def initialize(x, y, width, height, tex)
    super(x, y, width, height, tex, true)

    @dead = false

    $colliding << self

  end
  def kill
    $colliding.delete(self)
    @dead = true
  end
  def jump
    if @on_ground
      @velY = -13
    end
  end

  def move_left
    if @on_ground
      _acceleration = @acceleration
    else
      _acceleration = @air_acceleration
    end
    @accelX = -_acceleration
  end
  def move_right
    if @on_ground
      _acceleration = @acceleration
    else
      _acceleration = @air_acceleration
    end
    @accelX = _acceleration
  end

  def draw
    super unless @dead
  end
end