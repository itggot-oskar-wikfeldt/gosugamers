require_relative 'block'
class Levels
  def self.level1
    3.times do |i|
      Block.new(i*75-300, -i*50-50, 75, -25, 'grass', true)
      Block.new(-i*75+225, -i*50-50, 75, -25, 'grass', true)
      Block.new(i*75-300, -i*50, 75, -50, 'grass', false)
      Block.new(-i*75+225, -i*50, 75, -50, 'grass', false)
    end

    20.times do |i|
      Block.new(-i*16-700, -i*8, 16, -8, 'stone', true)
    end

    #20.times do |i|
    #  Block.new(-i*10-900, i*10-200, 10, 10, 'stone', true)
    #end
    #Block.new(-1000, -200, 500, 10, 'stone', true)


    Block.new(-1*75, -3*50, 2*75, -25, 'grass', true)
    Block.new(-1*75, -3*50, 2*75, 50, 'grass', false)
    Block.new(-2*75, -2*50, 4*75, 50, 'grass', false)
    Block.new(-3*75, -1*50, 6*75, 50, 'grass', false)

    Block.new(-5*75, 0, 75, -25, 'grass', true)
    Block.new(4*75, 0, 75, -25, 'grass', true)

    Block.new(-2000, 0, 4000, 50, nil, true)





    def self.blocks(x, y)
      y-=200
      Block.new(x+20, y+50, 50, 150, 'stone', false)
      Block.new(x+300-20, y+50, -50, 150, 'stone', false)
      Block.new(x, y, 300, 50, 'stone', true)
    end
    blocks(4*75+100, 0)
    blocks(4*75+100+300, 0)
    blocks(4*75+100+600, 0)
    blocks(4*75+100+150, -200)
    blocks(4*75+100+300+150, -200)

    Block.new(4*75+100+600+300, 0, 150, -50, 'stone', true)
    Block.new(4*75+100+600+300+60, -50, 50, -50, 'stone', true)



  end

  def self.level2

  end
end

