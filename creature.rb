require 'io/console'

class Creature
  attr_reader :gold, :x, :y, :health, :initial

  def initialize(x = nil, y = nil, health = nil, initial = nil)
    if x.nil?
      @x = 2 #TODO: randomize this
    else
      @x = x
    end

    if y.nil?
      @y = 2
    else
      @y = y
    end

    if health.nil?
      @health = 50
    else
      @heath = health
    end

    @gold =  0

    if initial.nil?
      @initial = "@"
    else
      @initial = initial
    end
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
    print 7.chr
    game.setMessage("You found #{goldFound} gold! You have #{@gold} now.")
    if @gold > 100
      system('say "You are so rich"')
    end
  end

  def decreaseGold(gold)
    @gold -= gold
  end

  def move(game, random = false)
    if random
      move = ['w','a','s','d'].sample
    else 
      game.increaseMoveCount
      puts "WASD/P/I/X ?"
      move = gets.chomp
    end
    if game.validMoves.include? move
      if move == 'w' #|| "\e[A"
        puts "Walking up..."
        if game.board[@y][@x + 1] == 'E'
          game.increaseFloor
          game.updateBoard
          game.printBoard(self)
        else
          unless game.obstacles.include? game.board[@y - 1][@x]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementY(-1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
          else
            game.setMessage("You bumped into something hard")
          end
        end
      elsif move == 'a' #|| "\e[D"
        puts "Walking left..."
        if game.board[@y][@x + 1] == 'E'
          game.increaseFloor
          game.updateBoard
          game.printBoard(self)
        else
          unless game.obstacles.include? game.board[@y][@x - 1]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementX(-1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
          else
            game.setMessage("You bumped into something hard")
          end
        end
      elsif move == 's' #|| "\e[B"
        puts "Walking down..."
        if game.board[@y][@x + 1] == 'E'
          game.increaseFloor
          game.updateBoard
          game.printBoard(self)
        else
          unless game.obstacles.include? game.board[@y + 1][@x]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementY(1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
          else
            game.setMessage("You bumped into something hard")
          end
        end
      elsif move == 'd' #|| "\e[C"
        puts "Walking right..."
        if game.board[@y][@x + 1] == 'E'
          game.increaseFloor
          game.updateBoard
          game.printBoard(self)
        else
          unless game.obstacles.include? game.board[@y][@x + 1]
            game.setMessage("")
            game.board[@y][@x] = "_"
            incrementX(1)
            if game.gold_tiles.include? game.board[@y][@x]
              increaseGold(game)
            end
            game.board[@y][@x] = @initial
          else
            game.setMessage("You bumped into something hard")
          end
        end
      elsif move == 'p'
        game.setMessage("You're at: #{@x}, #{@y}")
      elsif move == 'i'
        game.setMessage("You have #{@gold} gold now.")
      elsif move == 'x'
        game.setMessage("Thanks for playing!")
        return true
      end
    else
      game.setMessage(game.validMoves)
    end
    return false
  end
end
