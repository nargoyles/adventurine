require './creature'

class Monster < Creature
  attr_reader :gold, :x, :y, :attack

  def initialize(x = nil, y = nil, health, initial, attack = rand(5..10))
    super(x, y, health, initial)
    @attack = attack
    @initial = 'M'
  end

end
