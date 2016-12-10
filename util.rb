#require_relative './entity'
class Util
  def self.intersects?(entity1, entity2)

    return (((entity1.get_bound('top').between?(entity2.get_bound('top'), entity2.get_bound('bottom'))) ||
        (entity1.get_bound('bottom').between?(entity2.get_bound('top'), entity2.get_bound('bottom')))) &&
        ((entity1.get_bound('left').between?(entity2.get_bound('left'), entity2.get_bound('right'))) ||
            (entity1.get_bound('right').between?(entity2.get_bound('left'), entity2.get_bound('right'))))) ||
        (((entity2.get_bound('top').between?(entity1.get_bound('top'), entity1.get_bound('bottom'))) ||
            (entity2.get_bound('bottom').between?(entity1.get_bound('top'), entity1.get_bound('bottom')))) &&
            ((entity2.get_bound('left').between?(entity1.get_bound('left'), entity1.get_bound('right'))) ||
                (entity2.get_bound('right').between?(entity1.get_bound('left'), entity1.get_bound('right')))))

  end
end