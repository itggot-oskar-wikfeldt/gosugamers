require_relative './block.rb'
class Levels
  def self.level1
    4.times do |i|
      Block.new(i*75, i*50, 75, 50, 'grass', true, true)
    end
    4.times do |i|
      Block.new((-i-1)*75, i*50, 75, 50, 'grass', true, true)
    end
    4.times do |i|
      Block.new(i*75, i*50+50, 75, 50, 'grass', false, true)
    end
    4.times do |i|
      Block.new((-i-1)*75, i*50+50, 75, 50, 'grass', false, true)
    end

    Block.new(4*75, 4*50, $window_width, 50, 'stone', true, true)
    Block.new(-4*75, 4*50, -$window_width, 50, 'stone', true, true)


    def self.blocks(x, y)
      Block.new(x+20, y+50, 50, 150, 'stone', false, true)
      Block.new(x+300-20, y+50, -50, 150, 'stone', false, true)
      Block.new(x, y, 300, 50, 'stone', true, true)
    end
    blocks(4*75+100, 0)
    blocks(4*75+100+300, 0)
    blocks(4*75+100+600, 0)
    blocks(4*75+100+150, -200)
    blocks(4*75+100+300+150, -200)

    Block.new(4*75+100+600+300, (4*50), 150, -50, 'stone', true, true)
    Block.new(4*75+100+600+300+60, 4*50-50, 50, -50, 'stone', true, true)

  end

  def self.level2

  end
end

