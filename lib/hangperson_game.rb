class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if (letter == '') || !(letter =~ /[[:alpha:]]/) || (letter == nil)
      raise ArgumentError, "Guess must be a letter."
    end
    
    if @guesses.include?(letter.downcase)
      return false
    elsif @wrong_guesses.include?(letter.downcase)
      return false
    end
    
    if @word.include?(letter.downcase) 
      @guesses += letter.downcase
      return true
    elsif letter.length == 1 && letter =~ /[[:alpha:]]/
      @wrong_guesses += letter.downcase
      return true
    else
      return false
    end
  end
  
  def check_win_or_lose
    if word_with_guesses() == @word
      return :win
    elsif (@guesses.length + @wrong_guesses.length) == 7
      return :lose
    else
      return :play
    end
  end
  
  def word_with_guesses
    word_guess = ''
    word_arr = @word.split('')
    word_arr.each do |x|
      if @guesses.include?(x)
        word_guess += x
      else
        word_guess += "-"
      end
    end
    return word_guess
  end

end
