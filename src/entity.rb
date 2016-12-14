require_relative 'util'
require_relative 'game_window'
require_relative 'world'
require_relative 'game_object'
class Entity < GameObject
  def initialize(x, y, width, height, textures, draw)
    super(x, y, width, height, textures, draw)

    @on_ground = false

    @acceleration = 0.55
    @air_acceleration = 0.2
    @air_resistance = 0.1
    @friction = 0.3
    @max_speed = 5
    @velX = 0
    @velY = 0
    @temp_X = @x
    @temp_Y = @y
    @prev_X = @x
    @prev_Y = @y
    @accelX = 0
    @accelY = 0
    @touched = []

    @margin = 2
    @hitbox_top =     Block.new(@x+@margin/2,       @y,                   @width-@margin,    -(@max_speed+2+10), 'stone', false)
    @hitbox_bottom =  Block.new(@x+@margin/2,       get_bound('bottom'),  @width-@margin,   (@max_speed+2+10),   'stone', false)
    @hitbox_left =    Block.new(@x,                 @y+@margin/2,         -(@max_speed+2),  @height-@margin-10,  'stone', false)
    @hitbox_right =   Block.new(get_bound('right'), @y+@margin/2,         (@max_speed+2),   @height-@margin-10,  'stone', false)

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
    if @on_ground
      _deceleration = @friction*$factor
    else
      _deceleration = @air_resistance*$factor
    end

    if @velX > 0
      @velX -= _deceleration
      if @velX < 0
        @velX = 0
      end
    end

    if @velX < 0
      @velX += _deceleration
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

    @hitbox_top.x = @x+@margin/2
    @hitbox_bottom.x = @x+@margin/2
    @hitbox_top.y = @y-@hitbox_top.height
    @hitbox_bottom.y = get_bound('bottom')

    accelerate
    decelerate
    moveY


    @temp_Y = @y
    _aboves = []
    _belows = []
    _to_the_lefts = []
    _to_the_rigths = []

    @touched = []



    #@hitbox_top.x = @x+@margin/2
    #@hitbox_bottom.x = @x+@margin/2
    #@hitbox_top.y = @y-@hitbox_top.height
    #@hitbox_bottom.y = get_bound('bottom')
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
      _above = Util.closest(get_bound('top'), _aboves, 'bottom')
      @temp_Y = _above.get_bound('bottom')
      @touched << _above
    end

    unless _belows.empty?
      _below = Util.closest(get_bound('bottom'), _belows, 'top')
      @temp_Y = _below.get_bound('top')-@height
      @touched << _below
    end



    moveX
    @temp_X = @x

    #@hitbox_left.x = @x-@hitbox_left.width
    #@hitbox_right.x = get_bound('right')
    #@hitbox_left.y = @y+@margin/2
    #@hitbox_right.y = @y+@margin/2



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
      _to_the_right = Util.closest(get_bound('right'), _to_the_rigths, 'left')
      @temp_X = _to_the_right.get_bound('left')-@width
      @touched << _to_the_right

    end

    unless _to_the_lefts.empty?
      _to_the_left = Util.closest(get_bound('left'), _to_the_lefts, 'right')
      @temp_X = _to_the_left.get_bound('right')
      @touched << _to_the_left
    end


    @x=@temp_X
    @y=@temp_Y
    $colliding.each do |object|
      next if object == self
      if Util.intersects?(self, object)
        #p "hello"
        @x -= @velX*$factor
      end
    end
  end
end