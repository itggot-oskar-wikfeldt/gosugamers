require 'gosu'
require 'thread'
require_relative './player.rb'
require_relative './camera.rb'
require_relative './block.rb'
require_relative './util.rb'
require_relative './enemy.rb'
require_relative './levels.rb'

class GameWindow < Gosu::Window
  def initialize(caption)
    super($window_width = 640, $window_height = 480, false)
    self.caption = @caption = caption
    @background = Gosu::Image.new('./res/light_sky.jpg', :tileable => true)


    Levels.level1



    @player = Player.new(450, 150, Gosu::KbLeft, Gosu::KbRight, Gosu::KbUp)
    @player2 = Player.new(400, 150,Gosu::KbA, Gosu::KbD, Gosu::KbW)
    @enemies = []
    @prev_time = 0.0
    $delta = 0.0
    $factor = 0.0
    @count = 0
    @fps = 0
    @fps_avg = 0

    @fps_counter = Gosu::Font.new(32)
    0.times do |i|
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
    #self.caption = @fps

    @prev_time = Gosu::milliseconds.to_f
    @player.update
    @player2.update


    @enemies.each { |enemy| enemy.update }
    Camera.update(@player, @player2)

    close if Gosu::button_down? Gosu::KbEscape

  end

  def draw

    @background.draw(0, 0, 0)
    $objects.each { |object| object.draw }
    @fps_counter.draw("fps: #{@fps}", 5, 5, 0, 0.5, 0.5, 0xff_000000)

    #@player.draw
    #@enemies.each { |enemy| enemy.draw }

  end
end