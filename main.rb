require_relative 'lib/game'
require_relative 'lib/hangman_word'

puts "Would you like to load from a save file? (y/n)"
if gets.chomp == 'y'
  game = Game.new(true)
else
  game = Game.new(false)
end

until game.guess
  
end

puts "Thanks for playing!"