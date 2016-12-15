require_relative 'game_window'
class Camera
  def self.initialize
    $offsetX = ($window_width/2)
    $offsetY = ($window_height/2)
    @camera_speed = 10
  end

  def self.update(focus1, focus2)
    _focus_X = ($window_width/2) - (focus1.x+focus2.x)/2
    _focus_Y = ($window_height/2) - (focus1.y+focus2.y)/2
    if $offsetX < _focus_X
      $offsetX += @camera_speed
      if $offsetX > _focus_X
        $offsetX = _focus_X
      end
    end

    if $offsetX > _focus_X
      $offsetX -= @camera_speed
      if $offsetX < _focus_X
        $offsetX = _focus_X
      end
    end

    if $offsetY < _focus_Y
      $offsetY += @camera_speed
      if $offsetY > _focus_Y
        $offsetY = _focus_Y
      end
    end

    if $offsetY > _focus_Y
      $offsetY -= @camera_speed
      if $offsetY < _focus_Y
        $offsetY = _focus_Y
      end
    end
  end

end