require 'gosu'
require_relative 'player'
require_relative 'block'
require_relative 'util'
require_relative 'enemy'
require_relative 'levels'

class GameWindow < Gosu::Window
  include Gosu
  def initialize(caption)
    super($window_width = 1280, $window_height = 720, false)
    Camera.initialize
    self.caption = @caption = caption
    @background = Image.new('../res/light_sky_big.jpg', :tileable => true)
    @ground = Gosu::Image.new('../res/dirt.jpg', :tileable => true)
    @loading_screen = Image.new('../res/loading.png', :tileable => true)

    Levels.level1

    @player = Player.new(0, -300, [Gosu::KbLeft, Gosu::KbRight, Gosu::KbUp, Gosu::KbRightControl], true)
    @player2 = Player.new(50, -300, [Gosu::KbA, Gosu::KbD, Gosu::KbW, Gosu::KbSpace], false)
    @enemies = []
    0.times do |i|
      @enemies << Enemy.new(-500+i*500, -500, [@player, @player2])
    end

    @prev_time = 0.0
    $timepassed = 0.0
    $delta = 0.0
    $factor = 0.0
    @count = 0
    @fps = 0
    @fps_avg = 0

    @text = Gosu::Font.new(32)
  end

  def update
    $timepassed = Gosu::milliseconds.to_f/1000
    $delta = Gosu::milliseconds.to_f-@prev_time
    $factor = ($delta/1000)/(1.to_f/60)
    if @count < 10
      @count +=1
      begin
        @fps_avg += (1/($delta/1000)).to_i
      rescue FloatDomainError
      end


    else
      @fps = @fps_avg/10
      @fps_avg = 0
      @count = 0
    end
    #self.caption = @fps

    @prev_time = Gosu::milliseconds.to_f
    unless $timepassed < 3
      @player.update
      @player2.update
      @enemies.each { |enemy| enemy.update }
      Camera.update(@player, @player2)
    end


    close if Gosu::button_down? Gosu::KbEscape

  end

  def draw
    if $timepassed < 3
      @loading_screen.draw(0, 0, 0, $window_width.to_f/1920, $window_height.to_f/1080)
    else
      @background.draw(0, 0, 0, $window_width.to_f/1920, $window_height.to_f/1080)
      @ground.draw(0,$offsetY, 0, $window_width.to_f/1920, $window_height.to_f/1080)
      $objects.each { |object| object.draw }
      @text.draw("fps: #{@fps}", 5, 5, 0, 0.5, 0.5, 0xff_000000)
      @text.draw("player 1: #{@player.x.round(2)}", 5, 30, 0, 0.5, 0.5, 0xff_000000)
      @text.draw("player 2: #{@player2.x.round(2)}", 5, 45, 0, 0.5, 0.5, 0xff_000000)
      @text.draw("; #{(@player.get_bound('bottom')).round(2)}", 120, 30, 0, 0.5, 0.5, 0xff_000000)
      @text.draw("; #{(@player2.get_bound('bottom')).round(2)}", 120, 45, 0, 0.5, 0.5, 0xff_000000)
    end



  end
end