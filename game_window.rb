require 'gosu'
require_relative './player.rb'
require_relative './camera.rb'
require_relative './block.rb'
require_relative './util.rb'
require_relative './enemy.rb'

class GameWindow < Gosu::Window
  def initialize(caption)
    super($window_width = 640, $window_height = 480, false)
    self.caption = @caption = caption
    @background = Gosu::Image.new('./res/light_sky.jpg', :tileable => true)

    5.times do |i|
      $objects << Block.new(i*50+100, i*10+300, 50, 30, 'stone', true)
    end
    Block.new(300, 400, 200, 50, 'stone', true)

    Block.new(0, 400, $window_width, 50, 'stone', true)
    Block.new(0, 200, 50, 200, 'stone', true)
    Block.new($window_width-50, 200, 50, 200, 'stone', true)

    @player = Player.new(350, 150)
    @enemies = []
    @prev_time = 0.0
    $delta = 0.0
    $factor = 0.0
    @count = 0
    @fps = 0
    @fps_avg = 0

    @fps_counter = Gosu::Font.new(32)

    2.times do |i|
      @enemies << Enemy.new(120+60*i, 20, @player)
    end

  end

  def update

    $delta = Gosu::milliseconds.to_f-@prev_time
    $factor = ($delta/1000)/(1.to_f/60)
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
    @enemies.each { |enemy| enemy.update }
    Camera.update(@player)

    close if Gosu::button_down? Gosu::KbEscape
    p $factor
  end

  def draw
    @background.draw(0, 0, 0)
    $objects.each { |object| object.draw }
    @fps_counter.draw(@fps, 0, 0, 0, 1, 1, 0xff_ffffff)

    #@player.draw
    #@enemies.each { |enemy| enemy.draw }

  end
end