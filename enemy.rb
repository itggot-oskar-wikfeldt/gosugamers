require_relative './mob.rb'
class Enemy < Mob
  def initialize(x, y, target)
    super(x, y, 48, 33, [Gosu::Image.new('./res/slime.png')])
    @target = target

  end

  def update
    unless @dead
      @accelX = 0
      if (get_bound('left') > @target.get_bound('right')) && !@on_ground
        move_left
      end
      if (get_bound('right') < @target.get_bound('left')) && !@on_ground
        move_right
      end
      if rand(100) == 0
        jump
      end


      super
      if @y > $window_height*2
        kill
      end
    end

  end



  def draw
    unless @dead
      super
    end
  end
end