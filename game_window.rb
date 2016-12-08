require 'gosu'
require_relative './player.rb'
require_relative './enemy.rb'
require_relative './camera.rb'
class GameWindow < Gosu::Window
  def initialize(caption)
    super $window_width = 640, $window_height = 480, false
    @caption = caption
    self.caption = @caption
    @background = Gosu::Image.new('./res/light_sky.jpg', :tileable => true)
    @floor = Gosu::Image.new('./res/grass.jpg')
    @player = Player.new(20, 20)
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
    @floor.draw(0, 480-48 + $offsetY, 0)
    @player.draw
    @fps_counter.draw(@fps, 0,0,0,1,1,0xff_ffffff)
    @enemies.each do |enemy|
      enemy.draw
    end
  end
end