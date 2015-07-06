require './creature'

class Monster < Creature
  attr_reader :gold, :x, :y, :attack

  def initialize(x = nil, y = nil, health, initial, attack)
    super(x, y, health, initial)
    @attack = attack
  end

  def setX(x)
    @x = x
  end

  def incrementX(x)
    @x += x
  end

  def setY(y)
    @y = y
  end

  def incrementY(y)
    @y += y
  end

  def increaseGold(game)
    goldFound = Random.new.rand(1..20)
    @gold += goldFound
  end

  def monsterMove(game)
    mm=rand(1..5)
      if mm == 1
        unless
          game.obstacles.include? game.board[@y - 1][@x]
          game.setMessage("")
          game.board[@y][@x] = "_"
          incrementY(-1)
          if game.gold_tiles.include? game.board[@y][@x]
            increaseGold(game)
          end
          game.board[@y][@x] = @initial
        end
      elsif mm == 2
         unless game.obstacles.include? game.board[@y][@x - 1]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementX(-1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
        end
      elsif mm == 3
          unless game.obstacles.include? game.board[@y + 1][@x]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementY(1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
        end
      elsif mm == 4
          unless game.obstacles.include? game.board[@y][@x + 1]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementX(1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
        end
      elsif mm == 5
        game.board[@y][@x] = @initial
      end
    end
end
