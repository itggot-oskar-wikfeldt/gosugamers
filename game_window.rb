require 'gosu'
require_relative './player.rb'
require_relative './enemy.rb'
require_relative './camera.rb'
require_relative './block.rb'

class GameWindow < Gosu::Window
  def initialize(caption)
    super $window_width = 640, $window_height = 480, false
    @caption = caption
    self.caption = @caption
    @background = Gosu::Image.new('./res/light_sky.jpg', :tileable => true)
    @block1 = Block.new(0, $window_height-48, $window_width, 48, Gosu::Image.new('./res/pixel.png', :tileable => true))
    @block2 = Block.new(10, 10, $window_width, 48, Gosu::Image.new('./res/pixel.png', :tileable => true))
    @player = Player.new(50, 150)
    @enemies = []
    @prev_time = 0.0
    $delta = 0
    @count = 0
    @fps = 0
    @fps_avg = 0

    @fps_counter = Gosu::Font.new(32)
    0.times do
      @enemies << Enemy.new(40,20, @player)
    end

  end

  def update

    $delta = Gosu::milliseconds.to_f-@prev_time
    if @count < 10
      @count +=1
      @fps_avg += (1/($delta/1000)).to_i
    else
      @fps = @fps_avg/10
      @fps_avg = 0
      @count = 0
    end
    self.caption = @fps


    @prev_time = Gosu::milliseconds.to_f
    @player.update
    @enemies.each do |enemy|
      enemy.update
    end
    Camera.update(@player)



    close if Gosu::button_down? Gosu::KbEscape
  end
  def draw
    @background.draw(0,0,0)
    @block1.draw
    @block2.draw
    @player.draw
    @fps_counter.draw(@fps, 0,0,0,1,1,0xff_ffffff)
    @enemies.each {draw}


  end
end