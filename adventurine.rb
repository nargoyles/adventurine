require 'colorize'
system ("cls")
system "clear"

def addGold(board)
  r = Random.new
  board.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      rando = r.rand(1..100)
      board[row_index][col_index] = "g" if rando > 90
    end
  end
end

def printBoard(game, user)
  system ("cls")
  system "clear"
  game[:board].each do |row|
    row.each do |column|
      if column == user[:initial]
        print "#{column} ".green
      elsif column == "g"
        print "#{column} ".yellow
      else
        print "#{column} "
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
  move = gets.chomp.downcase
  if game[:validMoves].include? move
    if move == 'w'
      puts "Walking up..."
      if user[:y] - 1 >= 0 && game[:board][user[:y] - 1].length >= user[:x]
        game[:board][user[:y]][user[:x]] = "_"
        user[:y] -= 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] = "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into a wall"
      end
    elsif move == 'a'
      puts "Walking left..."
      if user[:x] - 1 >= 0
        game[:board][user[:y]][user[:x]] = "_"
        user[:x] -= 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] = "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into a wall"
      end
    elsif move == 's'
      puts "Walking down..."
      if user[:y] + 1 < game[:board].length && game[:board][user[:y] + 1].length >= user[:x]
        game[:board][user[:y]][user[:x]] = "_"
        user[:y] += 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] =  "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into a wall"
      end
    elsif move == 'd'
      puts "Walking right..."
      if user[:x] + 1 < game[:board][user[:y]].length
        game[:board][user[:y]][user[:x]] = "_"
        user[:x] += 1
        if game[:board][user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          game[:message] = "You found gold! You have #{user[:gold]} now."
        end
        game[:board][user[:y]][user[:x]] = user[:initial]
      else
        game[:message] = "You bumped into a wall"
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
  board: [
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"],
            ["_","_","_","_","_","_","_","_","_","_","_","_"]
          ],
  validMoves: ['w', 'a', 's', 'd', 'x', 'p', 'i'],
  moveCount: 0,
  message: ""
}

user = {
  gold: 0,
  x: 0,
  y: 0,
  name: "",
  initial: ""
}

addGold(game[:board])

puts "What is your character's name?"
name = gets.chomp
user[:name] = name
user[:initial] = name.chars[0].upcase

game[:board][user[:y]][user[:x]] = user[:initial]


loop do
  #Print the board each time through
  printBoard(game, user)
  quitGame = moveUser(game, user)
  break if quitGame
end
