class HangpersonGame

  attr_accessor :word
  attr_accessor :wrong_guesses
  attr_accessor :guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
 end

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
    @word.chars.map { |a| @guesses.include?(a) ? a : "-"}.join
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word.chars.map {|a| guesses.include? a}.all?
    return :play
  end 

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

