require_relative "hangman_word.rb"

class Game
  def initialize
    @word = HangmanWord.new.word
    @guess_correctness = @word.gsub(/[a-z]/,'_')
    @previous_guesses = Array.new
    @correct_guesses = Array.new
  end

  def guess
    print print_current_progress
    print_previous_guesses
    print_correct_guesses
    current_guess = get_character_input
    @previous_guesses.push current_guess
    @word.chars.each_with_index do |curr_letter, idx|
      if current_guess == curr_letter
        @guess_correctness[idx] = current_guess
        @correct_guesses.push current_guess unless @correct_guesses.include? current_guess
      end
    end
    if @guess_correctness  == @word
      puts "Congrats! The word was #{@word}!"
      return true
    end
    false
  end

  def print_current_progress
    print "Current progress: "
    @guess_correctness.chars.each_with_index do |letter,idx|
      print "#{letter} " unless idx == @guess_correctness.size - 1
      print "#{letter}" if idx == @guess_correctness.size - 1
    end
    puts
  end

  def print_previous_guesses
    print "Your previous guesses were: "
    @previous_guesses.each_with_index do |letter|
      print "#{letter}, " unless letter == @previous_guesses[-1]
      print "#{letter}." if letter == @previous_guesses[-1]
    end
    puts
  end

  def print_correct_guesses
    print "Your correct guesses were: "
    @correct_guesses.each_with_index do |letter|
      print "#{letter}, " unless letter == @previous_guesses[-1]
      print "#{letter}." if letter == @previous_guesses[-1]
    end
    puts
  end

  def get_character_input
    puts "Please choose a character to guess!"
    guess = gets.chomp
    until guess.size == 1 && !@previous_guesses.include?(guess)
      puts "Please enter a single character that has not already been guessed!"
      guess = gets.chomp
    end
    guess
  end
end

test = Game.new

until test.guess
  
end