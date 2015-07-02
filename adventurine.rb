require 'colorize'
system ("cls")
system "clear"

board = [
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
]

golds = 5
r = Random.new

board.each_with_index do |row, row_index|
  row.each_with_index do |col, col_index|
    rando = r.rand(1..100)
    board[row_index][col_index] = "g" if rando > 90
  end
end

user = {
  gold: 0,
  x: 0,
  y: 0,
  name: "",
  initial: ""
}
valid_moves = ['w', 'a', 's', 'd', 'x', 'p', 'i']

puts "What is your character's name?"
name = gets.chomp
user[:name] = name
user[:initial] = name.chars[0].upcase

board[user[:y]][user[:x]] = user[:initial]
index = 0
message = ""

loop do
  system ("cls")
  system "clear"
  #Print the board each time through
  board.each do |row|
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
  puts message
  if index == 0
    puts "You are in the northwestern most corner of a dungeon."
    puts "Use 'a' to move west, 's' to move south, 'w' to move north, and 'd' to move east"
    puts "Typing 'p' will show your position 'i' will show your inventory, and 'x' will quit"
  end
  index += 1
  puts "WASD?"
  move = gets.chomp.downcase
  if valid_moves.include? move
    if move == 'w'
      puts "Walking up..."
      if user[:y] - 1 >= 0 && board[user[:y] - 1].length >= user[:x]
        board[user[:y]][user[:x]] = "_"
        user[:y] -= 1
        if board[user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          message = "You found gold! You have #{user[:gold]} now."
        end
        board[user[:y]][user[:x]] = user[:initial]
      else
        message = "You bumped into a wall"
      end
    elsif move == 'a'
      puts "Walking left..."
      if user[:x] - 1 >= 0
        board[user[:y]][user[:x]] = "_"
        user[:x] -= 1
        if board[user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          message = "You found gold! You have #{user[:gold]} now."
        end
        board[user[:y]][user[:x]] = user[:initial]
      else
        message = "You bumped into a wall"
      end
    elsif move == 's'
      puts "Walking down..."
      if user[:y] + 1 < board.length && board[user[:y] + 1].length >= user[:x]
        board[user[:y]][user[:x]] = "_"
        user[:y] += 1
        if board[user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          message =  "You found gold! You have #{user[:gold]} now."
        end
        board[user[:y]][user[:x]] = user[:initial]
      else
        message = "You bumped into a wall"
      end
    elsif move == 'd'
      puts "Walking right..."
      if user[:x] + 1 < board[user[:y]].length
        board[user[:y]][user[:x]] = "_"
        user[:x] += 1
        if board[user[:y]][user[:x]] == 'g'
          user[:gold] += 10
          message = "You found gold! You have #{user[:gold]} now."
        end
        board[user[:y]][user[:x]] = user[:initial]
      else
        message = "You bumped into a wall"
      end
    elsif move == 'p'
      message = "You're at: #{user[:x]}, #{user[:y]}"
    elsif move == 'i'
      message = "You have #{user[:gold]} gold now."
    elsif move == 'x'
      message = "Thanks for playing!"
      break
    end
  else
    message = "Sorry, didn't understand that"
  end
end
