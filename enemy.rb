require_relative './entity.rb'
class Enemy < Entity
  def initialize(x, y, target)
    super(x, y, [Gosu::Image.new('./res/slime.png')], false)
    @width = 48
    @height = 33
    @target = target
    @scanner.height = @height-2
    @scanner.width = width-2
    @has_jumped = false
    $blocks << self
  end

  def update
    @accelX = 0
    if (get_bound('left') > @target.get_bound('right')) && !@on_ground
      @accelX = -1
    end
    if (get_bound('right') < @target.get_bound('left')) && !@on_ground
      @accelX = 1
    end
    if rand(100) == 0
      jump
    end




    super
  end
  def draw
    super
  end
end