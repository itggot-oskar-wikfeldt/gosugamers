require_relative './mob.rb'
class Enemy < Mob
  def initialize(x, y, targets)
    super(x, y, 48, 33, [Gosu::Image.new('../res/slime.png')])
    @targets = targets
    @target
    @max_speed = 4
    @moved_left = false
    @moved_right = false

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
          d = _smallest_dist
        end

      end


      if @on_ground
        @moved_left = false
        @moved_right = false
      end
      @accelX = 0
      if (get_bound('left') > @target.get_bound('right')) && !@on_ground && !@moved_right
        move_left
        @moved_left = true
      end
      if (get_bound('right') < @target.get_bound('left')) && !@on_ground && !@moved_left
        move_right
        @moved_right = true
      end
      if rand(100) == 0
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