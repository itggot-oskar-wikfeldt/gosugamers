class Player
  def initialize(x, y)
    #width = 56
    #heght = 52

    @x = x
    @y = y
    @velX = 0
    @velY = 0
    @accelX = 0
    @accelY = 0
    @texture = Gosu::Image.new('./res/bunny.png')
  end
  def fall
    if @y+52+@velY < 480-48
      @accelY = 2
    else
      @accelY = 0
      @velY = 0
    end

  end
  def accelerate
    @velX += @accelX
    @velY += @accelY
  end

  def move
    @x += @velX
    @y += @velY
  end

  def update
    fall
    accelerate
    move



  end

  def draw
    @texture.draw(@x, @y, 0)
  end
end