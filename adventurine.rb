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
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input.chomp.downcase
end

def createBoard
  board = []
  file = File.new("board.txt", "r")
  while (line = file.gets)
    board.push(line.chomp.chars)
  end
  file.close
  return board
end

def addGold(game)
  r = Random.new
  game[:board].each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      rando = r.rand(1..100)
      unless game[:obstacles].include? col
        if rando > 95 && col
          game[:board][row_index][col_index] = "g"
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
        print "#{column}".green
      elsif column == "g"
        print "#{column}".yellow
      else
        print "#{column}"
      end
    end
    puts ""
  end
  puts game[:message]
  if game[:moveCount] == 0
    puts "You are in the northwestern most corner of a dungeon."
    puts "Use 'a' to move west, 's' to move south, 'w' to move north, and 'd' to move east"
    puts "Typing 'p' will show your position 'i' will show your inventory, and 'x' will quit"
  end
end

def moveUser(game, user)
  game[:moveCount] += 1
  game[:validMoves].each do |move|
    print "#{move} "
  end
  print "?"
  move = read_char
  puts move
  if game[:validMoves].include? move
    if move == 'w' #|| "\e[A"
      puts "Walking up..."
      unless game[:obstacles].include? game[:board][user[:y] - 1][user[:x]]
        game[:board][user[:y]][user[:x]] = "_"
        user[:y] -= 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] = "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into something hard"
      end
    elsif move == 'a' #|| "\e[D"
      puts "Walking left..."
      unless game[:obstacles].include? game[:board][user[:y]][user[:x] - 1]
        game[:board][user[:y]][user[:x]] = "_"
        user[:x] -= 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] = "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into something hard"
      end
    elsif move == 's' #|| "\e[B"
      puts "Walking down..."
      unless game[:obstacles].include? game[:board][user[:y] + 1][user[:x]]
        game[:board][user[:y]][user[:x]] = "_"
        user[:y] += 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] =  "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into something hard"
      end
    elsif move == 'd' #|| "\e[C"
      puts "Walking right..."
      unless game[:obstacles].include? game[:board][user[:y]][user[:x] + 1]
        game[:board][user[:y]][user[:x]] = "_"
        user[:x] += 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] = "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into something hard"
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
game = {
  board: createBoard,
  validMoves: ['w', 'a', 's', 'd', 'x', 'p', 'i'],
  obstacles: ['|', '#', '•'],
  moveCount: 0,
  message: ""
}

user = {
  gold: 0,
  x: 1,
  y: 1,
  name: "",
  initial: ""
}

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
