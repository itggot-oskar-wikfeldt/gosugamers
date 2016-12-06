require_relative './game_window.rb'
class Camera
  $offsetX = 0
  $offsetY = 0
  def self.update(focus)
    $offsetX = -focus.x-focus.width/2 + ($window_width/2)
    $offsetY = -focus.y + ($window_height/2)
  end

end