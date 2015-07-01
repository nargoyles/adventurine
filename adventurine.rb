require 'pp' #so the board prints prettier

board = [
  ["_","_","_","_","g","_"],
  ["_","_","_","_","_","_"],
  ["_","_","_","_","g","_"],
  ["_","_","_","_","_","_"],
  ["_","g","_","_","_","_"],
  ["_","_","_","_","_","_"]
]

user_gold = 0
user_x = 0
user_y = 0
valid_moves = ['w', 'a', 's', 'd', 'x', 'p', 'i']

puts "What is your character's name?"
character = gets.chomp

board[user_y][user_x] = character.chars[0].upcase


board.each do |row|
  row.each do |column|
    print "#{column} "
  end
  puts ""
end
puts "You are in the northwestern most corner of a dungeon."
puts "Use 'a' to move west, 's' to move south, 'w' to move north, and 'd' to move east"
puts "Typing 'p' will show your position 'i' will show your inventory, and 'x' will quit"

loop do
  puts "WASD?"
  move = gets.chomp.downcase
  system ("cls")
  if valid_moves.include? move
    if move == 'w'
      puts "Walking up..."
      if user_y - 1 >= 0
        board[user_y][user_x] = "_"
        user_y -= 1
        if board[user_y][user_x] == 'g'
          user_gold += 10
          puts "You found gold! You have #{user_gold} now."
        end
        board[user_y][user_x] = character.chars[0].upcase
      else
        puts "You bumped into a wall"
      end
    elsif move == 'a'
      puts "Walking left..."
      if user_x - 1 >= 0
        board[user_y][user_x] = "_"
        user_x -= 1
        if board[user_y][user_x] == 'g'
          user_gold += 10
          puts "You found gold! You have #{user_gold} now."
        end
        board[user_y][user_x] = character.chars[0].upcase
      else
        puts "You bumped into a wall"
      end
    elsif move == 's'
      puts "Walking down..."
      if user_y + 1 < board.length
        board[user_y][user_x] = "_"
        user_y += 1
        if board[user_y][user_x] == 'g'
          user_gold += 10
          puts "You found gold! You have #{user_gold} now."
        end
        board[user_y][user_x] = character.chars[0].upcase
      else
        puts "You bumped into a wall"
      end
    elsif move == 'd'
      puts "Walking right..."
      if user_x + 1 < board[0].length
        board[user_y][user_x] = "_"
        user_x += 1
        if board[user_y][user_x] == 'g'
          user_gold += 10
          puts "You found gold! You have #{user_gold} now."
        end
        board[user_y][user_x] = character.chars[0].upcase
      else
        puts "You bumped into a wall"
      end
    elsif move == 'p'
      puts "You're at: #{user_x}, #{user_y}"
    elsif move == 'i'
      puts "You have #{user_gold} gold now."
    elsif move == 'x'
      puts "bye"
      break
    end
  else
    puts "Sorry, didn't understand that"
  end
  board.each do |row|
    row.each do |column|
      print "#{column} "
    end
    puts ""
  end
end
