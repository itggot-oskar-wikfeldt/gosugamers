require_relative 'mob'
class Enemy < Mob
  def initialize(x, y, targets)
    super(x, y, 48, 33, [Gosu::Image.new('../res/slime.png')], nil)
    @targets = targets
    @target
    @max_speed = 4
    @jump = false
    @moving_left = false
    @moving_right = false

  end

  def update
    unless @dead
      _smallest_dist = Util.distance(@targets[0], self)
      @target = @targets[0]
      @targets.each do |target|
        next if target == @targets[0]
        d = Util.distance(target, self)
        if d < _smallest_dist
          @target = target
          _smallest_dist = d
        end
      end
      @jump = false
      @touched.each do |touched|
        if touched.is_a?(Entity)
          @jump = true if rand(20) == 0
        end
      end

      if rand(100) == 0
        @jump = true
      end


      if @on_ground
        @moving_left = false
        @moving_right = false
      end


      @accelX = 0
      if (get_bound('left') > @target.get_bound('right')) && (@moving_left || @jump)
        move_left
        @moving_left = true
      end
      if (get_bound('right') < @target.get_bound('left')) && (@moving_right || @jump)
        move_right
        @moving_right = true
      end

      if @jump
        jump
      end
      if @y > $window_height*2
        kill
      end

      super

    end

  end


  def draw
    unless @dead
      super
    end
  end
end