require './user'
require './monster'
require './game'

#Start with a clean slate
system ("cls")
system "clear"

#Setup game
#Hardcode this for now
#puts "What is your character's name?"
#name = gets.chomp
user = User.new(1,1,100,"N", "Nate", 0)
monster = Monster.new(8,10,50,"M", 5)
game = Game.new
game.updateBoard(user)

loop do
  #Print the board each time through
  game.printBoard(user, monster)
  quitGame = user.move(game)
  break if quitGame #|| game[:moveCount] > 20
end
