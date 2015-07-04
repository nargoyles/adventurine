require 'colorize'
require 'io/console'

#Start with a clean slate
system ("cls")
system "clear"

def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  else
    input.chomp
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input.chomp.downcase
end

def updateBoard(game, user)
  user[:floor] += 1
  user[:x] = 1
  user[:y] = 1
  game[:board] = []
  file = File.new("#{user[:floor]}.txt", "r")
  while (line = file.gets)
    game[:board].push(line.chomp.chars)
  end
  file.close
  return game
end

def addGold(game)
  r = Random.new
  game[:board].each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      rando = r.rand(1..100)
      unless game[:obstacles].include? col
        unless game[:water_tiles].include? col
          unless col == "E"
            if rando > 97 && col
              game[:board][row_index][col_index] = game[:gold_tiles].sample
            end
          end
        end
      end
    end
  end
end

def printBoard(game, user)
  system ("cls")
  system "clear"
  game[:board].each do |row|
    row.each do |column|
      if column == user[:initial]
        print "#{column}".green.on_black.underline
      elsif game[:gold_tiles].include? column
        print "#{column}".yellow.on_black
      elsif game[:obstacles].include? column
        print "#{column}".white.on_black
      elsif game[:water_tiles].include? column
        print "#{column}".white.on_blue
      elsif column == "E"
        print "#{column}".white.on_black
      else
        print "#{column}".light_black.on_black
      end
    end
    puts ""
  end
  puts game[:message]
  if game[:moveCount] == 0
    puts "You are in the northwestern most corner of a dungeon."
    puts "Use 'a' to move west, 's' to move south, 'w' to move north, and 'd' to move east"
  end
end

def moveUser(game, user)
  game[:moveCount] += 1
  puts "WASD/P/I/X ?"
  move = read_char
  puts move
  if game[:validMoves].include? move
    if move == 'w' #|| "\e[A"
      puts "Walking up..."
      if game[:board][user[:y]][user[:x] + 1] == 'E'
        game = updateBoard(game, user) 
        printBoard(game, user)
      else
        unless game[:obstacles].include? game[:board][user[:y] - 1][user[:x]]
          game[:message] = ""
          game[:board][user[:y]][user[:x]] = "_"
          user[:y] -= 1
          if game[:gold_tiles].include? game[:board][user[:y]][user[:x]]
            user[:gold] += Random.new.rand(1..20)
            game[:message] = "You found gold! You have #{user[:gold]} now."
          end
          game[:board][user[:y]][user[:x]] = user[:initial]
        else
          game[:message] = "You bumped into something hard"
        end
      end
    elsif move == 'a' #|| "\e[D"
      puts "Walking left..."
      if game[:board][user[:y]][user[:x] + 1] == 'E'
        game = updateBoard(game, user) 
        printBoard(game, user)
      else
        unless game[:obstacles].include? game[:board][user[:y]][user[:x] - 1]
          game[:message] = ""
          game[:board][user[:y]][user[:x]] = "_"
          user[:x] -= 1
          if game[:gold_tiles].include? game[:board][user[:y]][user[:x]]
            goldFound = Random.new.rand(1..20)
            user[:gold] += goldFound
            print 7.chr
            game[:message] = "You found #{goldFound} gold! You have #{user[:gold]} now."
          end
          game[:board][user[:y]][user[:x]] = user[:initial]
        else
          game[:message] = "You bumped into something hard"
        end
      end
    elsif move == 's' #|| "\e[B"
      puts "Walking down..."
      if game[:board][user[:y]][user[:x] + 1] == 'E'
        game = updateBoard(game, user) 
        printBoard(game, user)
      else
        unless game[:obstacles].include? game[:board][user[:y] + 1][user[:x]]
          game[:message] = ""
          game[:board][user[:y]][user[:x]] = "_"
          user[:y] += 1
          if game[:gold_tiles].include? game[:board][user[:y]][user[:x]]
            user[:gold] += Random.new.rand(1..20)
            game[:message] =  "You found gold! You have #{user[:gold]} now."
          end
          game[:board][user[:y]][user[:x]] = user[:initial]
        else
          game[:message] = "You bumped into something hard"
        end
      end
    elsif move == 'd' #|| "\e[C"
      puts "Walking right..."
      if game[:board][user[:y]][user[:x] + 1] == 'E'
        puts "SUP"
        game = updateBoard(game, user) 
        printBoard(game, user)
      else
        unless game[:obstacles].include? game[:board][user[:y]][user[:x] + 1]
          game[:message] = ""
          game[:board][user[:y]][user[:x]] = "_"
          user[:x] += 1
          if game[:gold_tiles].include? game[:board][user[:y]][user[:x]]
            user[:gold] += Random.new.rand(1..20)
            game[:message] = "You found gold! You have #{user[:gold]} now."
          end
          game[:board][user[:y]][user[:x]] = user[:initial]
        else
          game[:message] = "You bumped into something hard"
        end
      end
    elsif move == 'p'
      game[:message] = "You're at: #{user[:x]}, #{user[:y]}"
    elsif move == 'i'
      game[:message] = "You have #{user[:gold]} gold now."
    elsif move == 'x'
      game[:message] = "Thanks for playing!"
      return true
    end
  else
    game[:message] = "Sorry, didn't understand that"
  end
  return false
end

#Setup game
user = {
  gold: 0,
  x: 1,
  y: 1,
  name: "",
  initial: "",
  floor: 0
}

game = {
  board: [],
  validMoves: ['w', 'a', 's', 'd', 'x', 'p', 'i'],
  obstacles: ['|', '#', '•'],
  water_tiles: ['~', '≈', ''],
  gold_tiles: ['*', '†', 'Ω'],
  moveCount: 0,
  message: ""
}

game = updateBoard(game, user)

addGold(game)

#Hardcode this for now
#puts "What is your character's name?"
#name = gets.chomp
name = "Nate"
user[:name] = name
user[:initial] = name.chars[0].upcase

game[:board][user[:y]][user[:x]] = user[:initial]


loop do
  #Print the board each time through
  printBoard(game, user)
  quitGame = moveUser(game, user)
  break if quitGame #|| game[:moveCount] > 20
end
