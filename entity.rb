require_relative './util.rb'
require_relative './camera.rb'
require_relative './game_window.rb'
require_relative './world.rb'
#require_relative './block.rb'
class Entity
  def initialize(x, y, left_tex, right_tex, static)

    @bound_left = @bound_right = @bound_top = @bound_bottom = 0
    @collidingX = false
    @collidingY = false
    @left = left_tex
    @right = @texture = right_tex
    @below
    @above
    @to_the_right
    @to_the_left
    @static = static
    @x = x
    @y = y
    @max_speed = 5
    @velX = 0
    @velY = 0
    @accelX = 0
    @accelY = 0
    @width = 0
    @height = 0
    @acceleration = 0.7
    @air_resistance = 0.1
    @friction = 0.5
    unless @static
      @scanner = Block.new(@x, @y, @width, @height, nil, false)
    end

  end

  attr_accessor :x, :y, :width

  def get_bound(bound)
    if bound == "left"
      return @x
    elsif bound == "right"
      return @x+@width
    elsif bound == "top"
      return @y
    else
      return @y + @height
    end

  end


  def accelerate
    if (@velX+@accelX).abs < @max_speed
      @velX += @accelX
    end
    @velY += @accelY
  end

  def decellerate
    if @velX > 0
      @velX -= @friction
    end

    if @velX < 0
      @velX+= @friction
    end

  end


  def move
    @x += @velX
    @y += @velY
  end

  def scan


    @scanner.y = @y+@height+1
    @scanner.x = @x+1

    @below = nil
    until @scanner.y > $window_height

      _break = false
      _blocks = []
      $blocks.each do |block|
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
      $blocks.each do |block|
        if Util.intersects?(@scanner, block)
          _blocks << block

          _break = true
        end

        if _blocks.size > 1

          smallest = 20000
          _blocks.each do |block|

            p (block.get_bound('bottom')-get_bound('top')).abs
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
      $blocks.each do |block|
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


    until @scanner.x+@width < 0
      _break = false
      $blocks.each do |block|
        if Util.intersects?(@scanner, block)
          @to_the_left = block

          _break = true
          break

        else
          @to_the_left = nil
        end


      end
      break if _break
      @scanner.x -=10
    end
  end


  def update
    unless @static
      scan
=begin
      if @below == nil
        puts 'below: nil'
      else
        puts "below: #{@below.y}"
      end
      if @above == nil
        puts 'above: nil'
      else
        puts "above: #{@above.y}"
      end
      if @to_the_right == nil
        puts 'to_the_right: nil'
      else
        puts "to_the_right: #{@to_the_right.x}"
      end
=end
      @accelY = $GRAVITY
      unless @below == nil
        if @y+(@velY+@accelY)+@height > @below.y
          @y = @below.y-@height
          @velY = 0
          @accelY = 0
        end

      end

      unless @above == nil
        if @y+(@velY+@accelY) < @above.y+@above.height
          @y = @above.y+@above.height
          @velY = 0
          @accelY = 0
        end

      end

      unless @to_the_right == nil
        if @x+(@velX+@accelX)+@width > @to_the_right.x
          @x = @to_the_right.x-@width
          @velX = 0
          @accelX = 0
        end
      end

      unless @to_the_left == nil
        if @x+(@velX+@accelX) < @to_the_left.x+@to_the_left.width
          @x = @to_the_left.x+@to_the_left.width
          @velX = 0
          @accelX = 0
        end
      end


      accelerate
      decellerate
      move
    end

  end

  def draw
    @texture.draw(@x + $offsetX, @y + $offsetY, 0)
  end

end