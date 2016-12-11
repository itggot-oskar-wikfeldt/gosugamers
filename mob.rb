require_relative './entity.rb'
class Mob < Entity
  def initialize(x, y, width, height, tex)
    super(x, y, width, height, tex)
    @has_jumped = false
    @dead = false
    $objects << self
    @acceleration = 0.6
    @air_resistance = 0.1
    @friction = 0.4
    @max_speed = 6
    @velX = 0
    @velY = 0
    @accelX = 0
    @accelY = 0
  end
  def kill
    $objects.delete(self)
    @dead = true
  end
  def jump
    @velY = -15 if @on_ground
  end

  def move_left
    @accelX = -1
  end
  def move_right
    @accelX = 1
  end
  def draw
    super unless @dead
  end
end