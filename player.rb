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
    @friction = 0.5
    @max_speed = 10
    @gravity = 1
    @has_jumped = false
    @on_ground = false
    @left = Gosu::Image.new('./res/bunny_left.png')
    @right = @texture = Gosu::Image.new('./res/bunny_right.png')
  end
  def fall
    if !@on_ground
      @accelY = @gravity
    else
      @accelY = 0
      @velY = 0
      @has_jumped = false
    end
  end
  def accelerate
    if @velX.abs < @max_speed
      @velX += @accelX
    end
    @velY += @accelY
  end
  def decellerate
    if @velX.abs > 0.1
      @velX > 0 ? @velX -= @friction : @velX += @friction
    else
      @velX = 0
    end

  end
  def move
    @x += @velX
    @y += @velY
  end

  def update

    @accelX = 0
    decellerate
    if Gosu::button_down? Gosu::KbLeft
      @accelX = -1
      @texture = @left
    end

    if Gosu::button_down? Gosu::KbRight
      @texture = @right
      @accelX = 1
    end
    if (Gosu::button_down? Gosu::KbUp) && @has_jumped == false
      @velY = -15
      @has_jumped = true
    end
    @y+52+@velY < 480-48 ? @on_ground = false : @on_ground = true
    fall
    accelerate
    move
    p @has_jumped





  end

  def draw
    @texture.draw(@x, @y, 0)
  end
end