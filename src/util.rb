#require_relative './entity'
class Util
  def self.intersects?(entity1, entity2)

    return (
    (
    (entity1.get_bound('top').between?(entity2.get_bound('top'), entity2.get_bound('bottom'))) ||
        (entity1.get_bound('bottom').between?(entity2.get_bound('top'), entity2.get_bound('bottom'))) ||

        (entity2.get_bound('top').between?(entity1.get_bound('top'), entity1.get_bound('bottom'))) ||
        (entity2.get_bound('bottom').between?(entity1.get_bound('top'), entity1.get_bound('bottom')))
    )&&
        (
        (entity1.get_bound('left').between?(entity2.get_bound('left'), entity2.get_bound('right'))) ||
            (entity1.get_bound('right').between?(entity2.get_bound('left'), entity2.get_bound('right'))) ||

            (entity2.get_bound('left').between?(entity1.get_bound('left'), entity1.get_bound('right'))) ||
            (entity2.get_bound('right').between?(entity1.get_bound('left'), entity1.get_bound('right')))
        )
    )

  end

  def self.distance(entity1, entity2)
    centerX_1 = entity1.x+entity1.width/2
    centerX_2 = entity2.x+entity2.width/2
    centerY_1 = entity1.y+entity1.height/2
    centerY_2 = entity2.y+entity2.height/2

    return Math.sqrt(((centerX_2-centerX_1)**2-(centerY_2-centerY_1)**2).abs)
  end
end