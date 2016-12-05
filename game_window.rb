require 'gosu'
require_relative './player.rb'

class GameWindow < Gosu::Window
  def initialize(caption)
    super @window_width = 640, @window_height = 480, false
    self.caption = caption
    @background = Gosu::Image.new('./res/dark_sky.jpg', :tileable => true)
    @floor = Gosu::Image.new('./res/rocks.jpg')
    @player = Player.new(20, 20)

  end

  def update




    close if Gosu::button_down? Gosu::KbEscape
  end
  def draw
    @background.draw(0,0,0)
    @floor.draw(0, 480-48, 0)
    @player.draw
  end
end