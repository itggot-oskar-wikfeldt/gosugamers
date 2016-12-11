require_relative './entity.rb'
class Player < Entity
  def initialize(x, y)
    super(x, y, [Gosu::Image.new('./res/bunny_right.png'), Gosu::Image.new('./res/bunny_left.png')], false)
    @width = 42
    @height = 39
    @scanner.height = @height-2
    @scanner.width = width-2
    @has_jumped = false
    $blocks << self
  end

  def update
    @accelX = 0
    if Gosu::button_down? Gosu::KbLeft
      @accelX = -1
      change_tex('left')
    end
    if Gosu::button_down? Gosu::KbRight
      @accelX = 1
      change_tex('right')
    end
    if Gosu::button_down? Gosu::KbSpace
      jump
    end
    if Gosu::button_down? Gosu::KbR
      @x = $window_width/2
      @y = 20
    end
    #@y  -=1 if Gosu::button_down? Gosu::KbUp
    #@y  +=1 if Gosu::button_down? Gosu::KbDown




    super
  end
  def draw
    super
  end
end