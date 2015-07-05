require './creature'

class User < Creature
  attr_reader :gold, :x, :y, :name, :floor

  def initialize(x = nil, y = nil, health, initial, name, floor)
    super(x, y, health, initial)
    @name = name
    @floor = floor
  end

  def setFloor(floor)
    @floor = floor
  end
end
