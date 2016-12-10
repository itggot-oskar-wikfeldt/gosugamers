require_relative './util.rb'
require_relative './camera.rb'
require_relative './game_window.rb'
require_relative './world.rb'
#require_relative './block.rb'
class Entity
  def initialize(x, y, left_tex, right_tex, static)

    @bound_left = @bound_right = @bound_top = @bound_bottom = 0

    @left = left_tex
    @right = @texture = right_tex
    @below
    @above
    @static = static
    @x = x
    @y = y

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

  def fall
    if !@collidingY
      @accelY = $GRAVITY
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
    else
      @velX = 0
    end


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

    @velY = -15


  end

  def move
    @tempX += @velX #*$delta/20
    @tempY += @velY #*$delta/20
  end

  def scan

    @scanner.x = @x
    @scanner.y = @y

    unless @y > $window_height
      until @scanner.y > $window_height
        break_it = false
        $blocks.each do |block|
          if Util.intersects?(@scanner, block)
            @below = block

            break_it = true
            break
          else

          end


        end
        break if break_it

        @scanner.y += @height
      end
    else
      @below = nil
    end

    @scanner.y = @y

    unless @y+@height < 0
      until @scanner.y+@height < 0
        break_it = false
        $blocks.each do |block|
          if Util.intersects?(@scanner, block)
            @above = block

            break_it = true
            break

          end



        end
        break if break_it
        @scanner.y -=@height
      end
    else
      @above = nil
    end
  end

  def update
    unless @static
      scan
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

      @y-=1
    end

  end

  def draw
    @texture.draw(@x + $offsetX, @y + $offsetY, 0)
  end

end