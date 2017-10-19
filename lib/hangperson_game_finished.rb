class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letter)
    raise ArgumentError unless letter =~ /^[a-z]$/i
    letter.downcase!
    if @word.include? letter
      return false if @guesses.include? letter
      @guesses += letter
    else
      return false if @wrong_guesses.include? letter
      @wrong_guesses += letter
    end
  end
  
  def word_with_guesses
    @word.chars.map { |ch| @guesses.include?(ch) ? ch : '-' }.join
  end
  
  def check_win_or_lose
    return :win if @word.chars.map { |ch| @guesses.include? ch }.all?
    return :lose if @wrong_guesses.length >= 7
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end