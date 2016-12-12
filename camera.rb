require_relative './game_window.rb'
class Camera
  $offsetX = 0
  $offsetY = 0
  def self.update(focus1, focus2)
    $offsetX = -(focus1.x+focus2.x)/2 + ($window_width/2)
    $offsetY = -(focus1.y+focus2.y)/2 + ($window_height/2)
  end

end