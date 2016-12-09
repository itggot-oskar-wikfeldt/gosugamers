require_relative './entity'
class Util
  def intersects?(entity1, entity2)
    if (entity1.get_bound('top').between?(entity2.get_bound('top'), entity2.get_bound('bottom')) ||
        entity1.get_bound('bottom').between?(entity2.get_bound('top'), entity2.get_bound('bottom'))) &&

    end
  end
end