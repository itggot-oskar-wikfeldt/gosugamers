require_relative './util.rb'
require_relative './camera.rb'
require_relative './game_window.rb'
require_relative './world.rb'
require_relative './object.rb'
class Entity < Object
  def initialize(x, y, width, height, textures)
    super(x, y, width, height, textures)

    @on_ground = false

    @below
    @above
    @to_the_right
    @to_the_left

    @acceleration = 0.6
    @air_resistance = 0.1
    @friction = 0.4
    @max_speed = 6
    @velX = 0
    @velY = 0
    @temp_X = @x
    @temp_Y = @y
    @accelX = 0
    @accelY = 0

    @scanner = Block.new(@x, @y, @width-2, @height-2, nil, false)

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
    if (@velX+@accelX).abs < @max_speed
      @velX += @accelX
    end
    @velY += @accelY
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

  def move
    @temp_X += @velX*$factor
    @temp_Y += @velY*$factor
  end

  def scan


    @scanner.y = @y+@height+1
    @scanner.x = @x+1

    @below = nil
    until @scanner.y > $window_height

      _break = false
      _blocks = []
      $objects.each do |block|
        @scanner.update
        if Util.intersects?(@scanner, block)
          _blocks << block
          _break = true
        end


      end

      if _blocks.size > 1
        smallest = 20000
        _blocks.each do |block|

          if (block.get_bound('top')-get_bound('bottom')).abs < smallest
            smallest = (block.get_bound('top')-get_bound('bottom')).abs
            @below = block
          end
        end
      else
        @below = _blocks[0]
      end

      break if _break

      @scanner.y += 10
    end


    @scanner.y = @y-@height-1


    @above = nil
    until @scanner.y+@height < 0
      _break = false
      _blocks = []
      $objects.each do |block|
        if Util.intersects?(@scanner, block)
          _blocks << block

          _break = true
        end

        if _blocks.size > 1

          smallest = 20000
          _blocks.each do |block|


            if (block.get_bound('bottom')-get_bound('top')).abs < smallest
              smallest = (block.get_bound('bottom')-get_bound('top')).abs
              @above = block

            end
          end
        else
          @above = _blocks[0]
        end


      end
      break if _break
      @scanner.y -=10
    end


    @scanner.x = @x+@width+1
    @scanner.y = @y+1

    @to_the_right = nil

    until @scanner.x > $window_width

      _break = false
      _blocks = []
      $objects.each do |block|
        if Util.intersects?(@scanner, block)
          _blocks << block

          _break = true


        end


      end

      if _blocks.size > 1

        smallest = 20000
        _blocks.each do |block|
          _delta = (block.get_bound('left')-get_bound('right')).abs
          if _delta < smallest
            smallest = _delta
            @to_the_right = block

          end
        end
      else
        @to_the_right = _blocks[0]
      end

      break if _break

      @scanner.x += 10
    end


    @scanner.x = @x-@width-1

    @to_the_left = nil
    until @scanner.x+@width < 0
      _break = false
      _blocks = []
      $objects.each do |block|
        if Util.intersects?(@scanner, block)
          _blocks << block

          _break = true

        end


      end


      if _blocks.size > 1

        smallest = 20000
        _blocks.each do |block|
          _delta = (block.get_bound('right')-get_bound('left')).abs
          if _delta < smallest
            smallest = _delta
            @to_the_left = block

          end
        end
      else
        @to_the_left = _blocks[0]
      end
      break if _break

      @scanner.x -=10
    end
  end

  def update
    @accelY = $GRAVITY
    scan

    @accelY*=$factor
    @accelX*=$factor

    @temp_X = @x
    @temp_Y = @y
    accelerate
    decelerate
    move
=begin
    unless @below == nil
      if @y+(@velY)+@height > @below.y
        @y = @below.y-@height
        @on_ground = true
        @velY = 0
        @accelY = 0
      else
        @on_ground = false
      end


    end

    unless @above == nil
      if @y+(@velY) < @above.y+@above.height
        @y = @above.y+@above.height
        @velY = 0
        @accelY = 0
      end

    end

    unless @to_the_right == nil
      if @x+(@velX)+@width > @to_the_right.x
        @x = @to_the_right.x-@width
        @velX = 0
        @accelX = 0
      end
    end

    unless @to_the_left == nil
      if @x+(@velX) < @to_the_left.x+@to_the_left.width
        @x = @to_the_left.x+@to_the_left.width
        @velX = 0
        @accelX = 0
      end
    end
=end

    unless @below == nil
      if @temp_Y+@height > @below.y
        @temp_Y = @below.y-@height
        @on_ground = true
        @velY = 0
        @accelY = 0
      else
        @on_ground = false
      end


    end

    unless @above == nil
      if @temp_Y < @above.y+@above.height
        @temp_Y = @above.y+@above.height
        @velY = 0
        @accelY = 0
      end

    end

    unless @to_the_right == nil
      if @temp_X+@width > @to_the_right.x
        @temp_X = @to_the_right.x-@width
        @velX = 0
        @accelX = 0
      end
    end

    unless @to_the_left == nil
      if @temp_X < @to_the_left.x+@to_the_left.width
        @temp_X = @to_the_left.x+@to_the_left.width
        @velX = 0
        @accelX = 0
      end
    end

    @x = @temp_X
    @y = @temp_Y
  end
end