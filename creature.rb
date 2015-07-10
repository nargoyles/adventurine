require 'io/console'

class Creature
  attr_reader :gold, :x, :y, :health, :initial, :attack

  def initialize(x = nil, y = nil, health = nil, initial = nil, attack = nil)
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
      @health = health
    end

    @gold =  0

    if initial.nil?
      @initial = "@"
    else
      @initial = initial
    end

    if attack.nil?
      @attack = 10
    else
      @attack = attack
    end
  end

  def decreaseHealth(attack)
    @health -= attack
  end

  def setX(x)
    @x = x
  end

  def incrementX(x)
    @x += x
  end

  def y=(value)
    @y = value
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

  def creatureCheck(toCheck)
    if toCheck.is_a? Array
      toCheck.each do |creature|
        if self.x == creature.x #check x
          unless self.y == creature.y - 1 || self.y == creature.y + 1 #check y +/- 1
            toCheck.delete creature #delete creature from toCheck
          end
        elsif self.y == creature.y
          unless self.x == creature.x - 1 || self.x == creature.x + 1
            toCheck.delete creature #delete creature from toCheck
          end
        else
          toCheck.delete creature #delete creature from toCheck
        end
      end
      return toCheck
    elsif toCheck.is_a? Creature
      if self.x == toCheck.x #check x
        if self.y == toCheck.y - 1 || self.y == toCheck.y + 1#check y +/- 1
          return toCheck
        else
          return nil
        end
      end
      if self.y == toCheck.y
        if self.x == toCheck.y - 1 || self.x == toCheck.y + 1
          return toCheck
        else
          return nil
        end
      end
    else
      return nil
    end
  end

#  def read_char
#    $stdin.echo = false
#    $stdin.raw!

#    input = $stdin.getc.chr
#    if input == "\e" then
#      input << $stdin.read_nonblock(3) rescue nil
#      input << $stdin.read_nonblock(2) rescue nil
#    else
#      input.chomp
#    end
#  ensure
#    $stdin.echo = true
#    $stdin.cooked!

#    return input.chomp.downcase
#  end

  def move(game, random = false)
    move = ['w','a','s','d'].sample
    unless random
      game.increaseMoveCount
      puts "WASD/P/I/X ?"
      move = gets.chomp
    end
    if game.validMoves.include? move
      if move == 'w' #|| "\e[A"
        puts "Walking up..."
        if game.board[@y][@x + 1] == 'E'
          game.increaseFloor
          game.loadBoard
          game.printBoard
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
          game.loadBoard
          game.printBoard
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
          game.loadBoard
          game.printBoard
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
          game.loadBoard
          game.printBoard
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
      elsif move == 'f'
        game.setMessage("You draw your sword.")
        toFight = self.creatureCheck(game.monsters)
        if toFight.is_a? Array
          toFight.each do |creature|
            creature.decreaseHealth(@attack)
            game.setMessage("#{game.message} You hit the monster! It now has #{@health} health.")
          end
        elsif toFight.is_a? Creature
          toFight.decreaseHealth(@attack)
          game.setMessage("#{game.message} You hit the monster! It now has #{@health} health.")
        else
          game.setMessage("#{game.message} Nothing is there.")
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
