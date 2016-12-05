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
    @max_speed = 20
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
    @velX += @accelX if @velX.abs < @max_speed
    @velY += @accelY if @velY.abs < @max_speed
  end
  def decellerate
    if @accelX.abs > 0.5
      @accelX > 0 ? @accelX -= 1 : @accelX += 1
    end
  end
  def move
    @x += @velX
    @y += @velY
  end

  def update
    if (Gosu::button_down? Gosu::KbLeft) && (@accelX > -7)
      @accelX -= 1
    end
    if (Gosu::button_down? Gosu::KbRight) && (@accelX < 7)
      @accelX += 1
    end
    fall
    decellerate
    accelerate
    move



  end

  def draw
    @texture.draw(@x, @y, 0)
  end
end