require './creature'

class User < Creature
  attr_reader :gold, :x, :y, :name, :floor

  def initialize(x = nil, y = nil, health, initial, name)
    super(x, y, health, initial)
    @name = name
  end
end
