require_relative './entity.rb'
class Player < Entity
  def initialize(x, y)
    super(x, y, Gosu::Image.new('./res/bunny_left.png'), Gosu::Image.new('./res/bunny_right.png'), false)
    @prev_dir_right = true
    @dir_right = true
    @width = 42
    @height = 39
    @scanner.height = @height-2
    @scanner.width = width-2
    @has_jumped = false
  end

  def update
    @accelX = 0
    @accelX = -1 if Gosu::button_down? Gosu::KbLeft
    @accelX = 1 if Gosu::button_down? Gosu::KbRight
    if (Gosu::button_down? Gosu::KbSpace) && @velY == 0 #!@has_jumped
      @velY = -10
      @has_jumped = true
    end
    #@y  -=1 if Gosu::button_down? Gosu::KbUp
    #@y  +=1 if Gosu::button_down? Gosu::KbDown




    super
  end
  def draw
    super
  end
end