class Player
  def initialize(x, y)
    @x = x
    @y = y
    @vel = 0
    @accel = 0
    @texture = Gosu::Image.new('./res/bunny.png')
  end

  def draw
    @texture.draw(@x, @y, 0)
  end
end