require_relative './camera.rb'
require_relative './game_window.rb'
class Entity
  def initialize(x, y, left_tex, right_tex)

    @bound_left = @bound_right = @bound_top = @bound_bottom = 0

    @left = left_tex
    @right = @texture = right_tex



    @x = @tempX = x
    @y = @tempY = y


    @velX = 0
    @velY = 0
    @accelX = 0
    @accelY = 0
    @acceleration = 0.7
    @base_friction = 0.5
    @max_speed = 10
    @gravity = 0.8
    @has_jumped = false
    @collidingY = false
    @collidingX = false

  end


  attr_reader :x, :y, :width

  def fall
    if !@collidingY
      @accelY = @gravity
    else
      @accelY = 0
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
    if @velX.abs > @friction
      if @velX > 0
        @velX -= @friction
      end

      if @velX < 0
        @velX += @friction
      end
    else @velX = 0 end




  end

  def go_left
    @texture = @left
    if @collidingY
      @accelX -=@acceleration
    else
      @accelX -=@acceleration*0.5
    end



  end

  def go_right
    @texture = @right
    if @collidingY
      @accelX +=@acceleration
    else
      @accelX +=@acceleration*0.5
    end


  end

  def jump
    if !@has_jumped
      @velY = -15
      @has_jumped = true
    end
  end

  def move()
    @tempX += @velX#*$delta/20
    @tempY += @velY#*$delta/20
  end

  def update
    @tempX = @x
    @tempY = @y

    @collidingY = true
    @collidingX = true

    while @collidingY && @collidingX
      if @collidingY
        @friction = @base_friction
      else
        @friction = 0.1
      end

      #fall
      @accelY = @gravity
      decellerate
      accelerate
      move
      @bound_left = @tempX
      @bound_right = @tempX + @width
      @bound_top = @tempY
      @bound_bottom = @tempY + @height

      if (@bound_left<0 or @bound_right>$window_width)
        @collidingX = true
      else
        @collidingX = false
      end

      if (@bound_bottom > $window_height-48) or (@bound_top < 0)
        @collidingY = true
      else
        @collidingY = false
      end

      if !@collidingX
        @x = @tempX
      end
      if !@collidingY
        @y = @tempY
      end
    end



  end

  def draw
    @texture.draw(@x + $offsetX, @y + $offsetY, 0)
  end

end