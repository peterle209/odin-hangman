require_relative "hangman_word.rb"

class Game
  attr_accessor :word, :guess_correctness, :previous_guesses, :correct_guesses


  def initialize(load)
    if load
      load()
      return
    end
    @word = HangmanWord.new.word
    @guess_correctness = @word.gsub(/[a-z]/,'_')
    @previous_guesses = Array.new
    @correct_guesses = Array.new
  end

  def guess
    print print_current_progress
    print_previous_guesses
    print_correct_guesses
    puts "Would you like to save the current game state?(y/n)"
    if gets.chomp == 'y'
      save
      puts "Would you like to quit? (y/n)"
      if gets.chomp == 'y'
        return true
      end
    end
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

  def save
    serialized_obj = Marshal.dump(self)
    unless Dir.exist?('saves')
      Dir.mkdir('saves')
    end
    puts "What would you like your save file to be called?"
    save_title = "./saves/#{gets.chomp}.txt"
    save_file = File.open(save_title,'wb')
    save_file.write serialized_obj
    save_file.close
    puts 'Save success!'
  end
  
  def load
    unless Dir.exist?('saves')
      puts "You have no existing save files!"
      return false
    end
    puts "What file would you like to load from? (omit .txt and directory path, enter only file title)"
    save_title = "./saves/#{gets.chomp}.txt"
    until File.exist?(save_title)
      puts "This save file does not exist. Try re-inputting, otherwise type 'quit'"
      save_title = gets.chomp
      return false if save_title == 'quit'
      save_title = "./saves/#{save_title}.txt"
    end
    save = File.read(save_title)
    save = Marshal.load(save)
    @correct_guesses = save.correct_guesses
    @word = save.word
    @guess_correctness = save.guess_correctness
    @previous_guesses = save.previous_guesses
  end
end