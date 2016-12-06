require_relative './entity.rb'
class Player < Entity
  def initialize(x, y)
    super(x, y, Gosu::Image.new('./res/bunny_left.png'), Gosu::Image.new('./res/bunny_right.png'))
    @prev_dir_right = true
    @dir_right = true
  end

  def update

    @accelX = 0
    if Gosu::button_down? Gosu::KbLeft
      go_left
      @dir_right = false
      if @prev_dir_right != @dir_right
        @velX = 0
        @prev_dir_right = @dir_right
      end
    end

    if Gosu::button_down? Gosu::KbRight
      go_right
      @dir_right = true
      if @prev_dir_right != @dir_right
        @velX = 0
        @prev_dir_right = @dir_right
      end
    end
    if (Gosu::button_down? Gosu::KbSpace or Gosu::button_down? Gosu::KbUp)
      jump
    end
    super
  end
  def draw
    super
  end
end