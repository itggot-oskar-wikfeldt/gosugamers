require_relative './util.rb'
require_relative './game_window.rb'
require_relative './world.rb'
require_relative './game_object.rb'
class Entity < GameObject
  def initialize(x, y, width, height, textures, draw)
    super(x, y, width, height, textures, draw)

    @on_ground = false

    @acceleration = 0.6
    @air_resistance = 0.1
    @friction = 0.4
    @max_speed = 6
    @velX = 0
    @velY = 0
    @temp_X = @x
    @temp_Y = @y
    @prev_X = @x
    @prev_Y = @y
    @accelX = 0
    @accelY = 0

    @margin = 2
    @hitbox_top =     Block.new(@x+@margin/2,       @y,                   @width-@margin,    -(@max_speed+2), nil, false,   false)
    @hitbox_bottom =  Block.new(@x+@margin/2,       get_bound('bottom'),  @width-@margin,   (@max_speed+2), nil, false,     false)
    @hitbox_left =    Block.new(@x,                 @y+@margin/2,         -(@max_speed+2),  @height-@margin, nil, false,    false)
    @hitbox_right =   Block.new(get_bound('right'), @y+@margin/2,         (@max_speed+2),   @height-@margin, nil, false,    false)

  end

  def change_tex(tex)
    if tex == 'right'
      @texture = @textures[0]
    elsif tex == 'left'
      @texture = @textures[1]
    elsif tex == 'up'
      @texture = @textures[2]
    else
      @texture = @textures[3]
    end
  end

  def accelerate
    if (@velX+@accelX*$factor).abs < @max_speed

      @velX += @accelX*$factor


    end
    @velY += @accelY*$factor
  end

  def decelerate
    if @velX > 0
      @velX -= @friction*$factor
      if @velX < 0
        @velX = 0
      end
    end

    if @velX < 0
      @velX+= @friction*$factor
      if @velX > 0
        @velX = 0
      end
    end
  end

  def moveX
    @x += @velX*$factor
  end

  def moveY
    @y += @velY*$factor
  end

  def update

    @prev_X = @x
    @prev_Y = @y

    @accelY = $GRAVITY

    accelerate
    decelerate
    moveY


    @temp_Y = @y
    _aboves = []
    _belows = []
    _to_the_lefts = []
    _to_the_rigths = []



    @hitbox_top.x = @x+@margin/2
    @hitbox_bottom.x = @x+@margin/2
    @hitbox_top.y = @y
    @hitbox_bottom.y = get_bound('bottom')
    @on_ground = false
    $colliding.each do |object|
      next if object == self
      if Util.intersects?(@hitbox_top, object)

        if get_bound('top') < object.get_bound('bottom')
          @velY = 0
          _aboves << object

        end

      end

      if Util.intersects?(@hitbox_bottom, object)

        if get_bound('bottom') > object.get_bound('top')
          @velY = 0
          _belows << object
          @on_ground = true
        end
      end
    end
    @y = @prev_Y
    unless _aboves.empty?
      @temp_Y = Util.closest(get_bound('top'), _aboves, 'bottom').get_bound('bottom')
    end

    unless _belows.empty?
      @temp_Y = Util.closest(get_bound('bottom'), _belows, 'top').get_bound('top')-@height
    end



    moveX
    @temp_X = @x

    @hitbox_left.x = @x
    @hitbox_right.x = get_bound('right')
    @hitbox_left.y = @y+@margin/2
    @hitbox_right.y = @y+@margin/2



    $colliding.each do |object|
      next if object == self
      if Util.intersects?(@hitbox_left, object)

        if get_bound('left') < object.get_bound('right')
          @velX = 0
          _to_the_lefts << object
        end
      end

      if Util.intersects?(@hitbox_right, object)
        if get_bound('right') > object.get_bound('left')
          @velX = 0
          _to_the_rigths << object
        end
      end
    end
    @x = @prev_X
    unless _to_the_rigths.empty?
      @temp_X = Util.closest(get_bound('right'), _to_the_rigths, 'left').get_bound('left')-@width
    end

    unless _to_the_lefts.empty?
      @temp_X = Util.closest(get_bound('left'), _to_the_lefts, 'right').get_bound('right')
    end


    @x=@temp_X
    @y=@temp_Y
  end
end