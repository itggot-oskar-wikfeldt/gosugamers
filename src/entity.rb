require_relative 'util'
require_relative 'game_window'
require_relative 'world'
require_relative 'game_object'
class Entity < GameObject
  def initialize(x, y, width, height, textures, draw)
    textures[base_tex] = textures
    super(x, y, width, height, textures, draw)

    @on_ground = false
    @textures = textures
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
    @direction = 'left'
    @touched = []

    @margin = 2
    @hitbox_top =     Block.new(@x+@margin/2,       @y,                   @width-@margin,    -(@max_speed+2+10), nil, false)
    @hitbox_bottom =  Block.new(@x+@margin/2,       get_bound('bottom'),  @width-@margin,   (@max_speed+2+10),   nil, false)
    @hitbox_left =    Block.new(@x,                 @y+@margin/2,         -(@max_speed+2),  @height-@margin-10,  nil, false)
    @hitbox_right =   Block.new(get_bound('right'), @y+@margin/2,         (@max_speed+2),   @height-@margin-10,  nil, false)

    @hitbox_half_player = Block.new(@x, @y+@height/2,         @width,   @height/2,  nil, false)

  end

  def change_tex(tex)
    if tex == 'right'
      @texture = @textures[right]
    elsif tex == 'left'
      @texture = @textures[left]
    elsif tex == 'up'
      @texture = @textures[up]
    else
      @texture = @textures[down]
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

    @hitbox_left.x = @x-@hitbox_left.width
    @hitbox_right.x = get_bound('right')
    @hitbox_left.y = @y+@margin/2
    @hitbox_right.y = @y+@margin/2

    @hitbox_half_player.x = @x
    @hitbox_half_player.y = @y+@height/2
=begin
    $colliding.each do |object|
      next if object == self
      if Util.intersects?(@hitbox_half_player, object)
        @y = object.get_bound('top')-@height
      end

      if Util.intersects?(self, object)
        @x -= @velX
      end
    end
=end
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

    @hitbox_half_player.x = @x
    @hitbox_half_player.y = @y+@height/2

    $colliding.each do |object|
      next if object == self
      if Util.intersects?(@hitbox_half_player, object)
        @y = object.get_bound('top')-@height
        $colliding.each do |obj|
          next if obj == self
          if Util.intersects?(self, obj)
            @y = obj.get_bound('bottom')
            if @velX > 0
              @x = object.get_bound('left')
            else
              @x = object.get_bound('right')
            end

          end
        end

      end


    end


  end
end