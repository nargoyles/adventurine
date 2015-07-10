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
user = User.new(1,1,100,"N",10,"Nate")
game = Game.new(user)

loop do
  #Print the board each time through
  game.printBoard
  quitGame = game.user.move(game)
  break if quitGame #|| game[:moveCount] > 20
  game.moveMonsters
end
