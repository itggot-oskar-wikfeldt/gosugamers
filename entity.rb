require_relative './camera.rb'
require_relative './game_window.rb'
class Entity
  def initialize(x, y, left_tex, right_tex)
    @width = 56
    @height = 52
    @bound_left = @bound_right = @bound_top = @bound_bottom = 0

    @left = left_tex
    @right = @texture = right_tex



    @x = x
    @y = y
    @velX = 0
    @velY = 0
    @accelX = 0
    @accelY = 0
    @acceleration = 0.8
    @friction = 1
    @max_speed = 10
    @gravity = 1
    @has_jumped = false
    @on_ground = false

  end

  attr_accessor :x
  attr_accessor :y
  attr_reader :width

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
    if @velX.abs > 0.3
      @velX > 0 ? @velX -= @friction : @velX += @friction
    else
      @velX = 0
    end

  end

  def go_left
    @accelX -=@acceleration
    @texture = @left
  end

  def go_right
    @texture = @right
    @accelX +=@acceleration
  end

  def jump
    if !@has_jumped
      @velY = -15
      @has_jumped = true
    end
  end

  def move
    @x += @velX*$delta/20
    @y += @velY*$delta/20
  end

  def update

    @bound_left = @x
    @bound_right = @x + @width
    @bound_top = @y
    @bound_bottom = @y + @height


    @bound_bottom+@velY < 480-48 ? @on_ground = false : @on_ground = true
    fall
    if @on_ground
      @friction = 0.5
    else
      @friction = 0.1
    end

    decellerate
    accelerate
    move
  end

  def draw
    @texture.draw(@x + $offsetX, @y + $offsetY, 0)
  end

end