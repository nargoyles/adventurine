require './creature'

class Monster < Creature
  attr_reader :gold, :x, :y, :attack

  def initialize(x = nil, y = nil, health, initial, attack)
    super(x, y, health, initial)
    @attack = attack
  end
end
