require_relative 'game_window'
class Camera
  def self.initialize
    $offsetX = ($window_width/2)
    $offsetY = ($window_height/2)
  end

  def self.update(focus1, focus2)
    $offsetX = ($window_width/2) - (focus1.x+focus2.x)/2
    $offsetY = ($window_height/2) - (focus1.y+focus2.y)/2
  end

end