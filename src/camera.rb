require_relative 'game_window'
class Camera
  def self.initialize
    $offsetX = ($window_width/2)
    $offsetY = ($window_height/2)
    @camera_speed_X = 3
    @camera_speed_Y = 3
  end

  def self.update(focus1, focus2)
    _focus_X = ($window_width/2) - (focus1.x+focus2.x)/2
    _focus_Y = ($window_height/2) - (focus1.y+focus2.y)/2
    @camera_speed_X = (_focus_X-$offsetX).abs/10
    @camera_speed_Y = (_focus_Y-$offsetY).abs/10
    if $offsetX < _focus_X
      $offsetX += @camera_speed_X
      if $offsetX > _focus_X
        $offsetX = _focus_X
      end
    end

    if $offsetX > _focus_X
      $offsetX -= @camera_speed_X
      if $offsetX < _focus_X
        $offsetX = _focus_X
      end
    end

    if $offsetY < _focus_Y
      $offsetY += @camera_speed_Y
      if $offsetY > _focus_Y
        $offsetY = _focus_Y
      end
    end

    if $offsetY > _focus_Y
      $offsetY -= @camera_speed_Y
      if $offsetY < _focus_Y
        $offsetY = _focus_Y
      end
    end
  end

end