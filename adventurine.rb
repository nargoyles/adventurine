require 'pp' #so the board prints prettier
board = [
  ["_","_","_","_","_","_",],
  ["_","_","_","_","_","_",],
  ["_","_","_","_","_","_",],
  ["_","_","_","_","_","_",],
  ["_","_","_","_","_","_",],
  ["_","_","_","_","_","_",],
]
user_pos = [0,0]
a = [-1,0]
s = [0,1]
w = [0,-1]
d = [1,0]
pp board
print "You are in the northwestern most corner of a dungeon. Use 'a' to move west, 's' to move south, 'w' to move north, and 'd' to move east: "
user_input = gets()
if user_input == 'a' then user_pos = user_pos.zip(a).map { |x,y| } x+y } #if input is a then add user_pos array to a array and store it in user_pos
elsif user_input == 'b' then user_pos=user_pos.zip(b).map { |x,y|} x+y }
end #same thing if input is b...etc
end
