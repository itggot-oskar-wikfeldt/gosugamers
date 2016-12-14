class Util

  def self.in_between?(num1, num2, num3)
    return ((num1 > num2) && (num1 < num3)) || ((num1 < num2) && (num1 > num3))
  end

  def self.intersects?(entity1, entity2)

    return (


    (
    (
    in_between?(entity1.get_bound('top'), entity2.get_bound('top'), entity2.get_bound('bottom')) ||
        in_between?(entity1.get_bound('bottom'), entity2.get_bound('top'), entity2.get_bound('bottom')) ||

        in_between?(entity2.get_bound('top'), entity1.get_bound('top'), entity1.get_bound('bottom')) ||
        in_between?(entity2.get_bound('bottom'), entity1.get_bound('top'), entity1.get_bound('bottom'))
    )&&(
    in_between?(entity1.get_bound('left'), entity2.get_bound('left'), entity2.get_bound('right')) ||
        in_between?(entity1.get_bound('right'), entity2.get_bound('left'), entity2.get_bound('right')) ||

        in_between?(entity2.get_bound('left'), entity1.get_bound('left'), entity1.get_bound('right')) ||
        in_between?(entity2.get_bound('right'), entity1.get_bound('left'), entity1.get_bound('right'))
    )
    ) || (
    (
    ((entity1.get_bound('top') == entity2.get_bound('top')) && (entity1.get_bound('bottom') == entity2.get_bound('bottom')))&&(
    ((entity1.get_bound('left') == entity2.get_bound('left')) && (entity1.get_bound('right') == entity2.get_bound('right'))) ||
        (
        in_between?(entity1.get_bound('left'), entity2.get_bound('left'), entity2.get_bound('right')) ||
            in_between?(entity1.get_bound('right'), entity2.get_bound('left'), entity2.get_bound('right')) ||

            in_between?(entity2.get_bound('left'), entity1.get_bound('left'), entity1.get_bound('right')) ||
            in_between?(entity2.get_bound('right'), entity1.get_bound('left'), entity1.get_bound('right'))
        )
    ))||(
    ((entity1.get_bound('left') == entity2.get_bound('left')) && (entity1.get_bound('right') == entity2.get_bound('right')))&&(
    ((entity1.get_bound('top') == entity2.get_bound('top')) && (entity1.get_bound('bottom') == entity2.get_bound('bottom'))) ||
        (
        in_between?(entity1.get_bound('top'), entity2.get_bound('top'), entity2.get_bound('bottom')) ||
            in_between?(entity1.get_bound('bottom'), entity2.get_bound('top'), entity2.get_bound('bottom')) ||

            in_between?(entity2.get_bound('top'), entity1.get_bound('top'), entity1.get_bound('bottom')) ||
            in_between?(entity2.get_bound('bottom'), entity1.get_bound('top'), entity1.get_bound('bottom'))
        )
    ))

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

  def self.closest(a, b_ary, bound)
    _smallest = (b_ary[0].get_bound(bound)-a).abs
    _closest = b_ary[0]
    b_ary.each do |object|
      next if object == b_ary[0]
      if (object.get_bound(bound)-a).abs < _smallest
        _smallest = (object.get_bound(bound)-a).abs
        _closest = object
      end
    end
    return _closest
  end

end