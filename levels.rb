require_relative './block.rb'
class Levels
  def self.level1
    4.times do |i|
      Block.new(i*75, i*50, 75, 50, 'grass', true, true)
    end
    4.times do |i|
      Block.new((-i-1)*75, i*50, 75, 50, 'grass', true, true)
    end

    Block.new(4*75, 4*50, $window_width, 50, 'stone', true, true)
    Block.new(-4*75, 4*50, -$window_width, 50, 'stone', true, true)


    def self.blocks(x, y)
      Block.new(x+20, y+50, 50, 150, 'stone', false, true)
      Block.new(x+300-20, y+50, -50, 150, 'stone', false, true)
      Block.new(x, y, 300, 50, 'stone', true, true)
    end
    blocks(4*75+100, 0)
    blocks(4*75+100, -200)
  end
end

def self.level2
  
end