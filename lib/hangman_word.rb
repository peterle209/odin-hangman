class HangmanWord
  MIN_LENGTH = 5
  MAX_LENGTH = 12
  POSSIBLEWORDS = 9894

  attr_reader :word

  def initialize
    @word = get_word
  end

  def get_word
    word = nil
    until check_valid word
      random_idx = rand(POSSIBLEWORDS)
      word = File.readlines('dict.txt')[random_idx]
    end
    word.chomp
  end

  def check_valid(word)
    return true if !word.nil? && word.size >= MIN_LENGTH && word.size <= MAX_LENGTH
    false
  end
end