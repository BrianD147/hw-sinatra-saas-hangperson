class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess (letter)
    
    if char.nil? or /[^A-Za-z]/.match(char) != nil or char == ''
  		raise ArgumentError.new("Not a valid letter")
    end
    
    letter = letter.downcase
    
    if @guesses.include? letter or @wrong_guesses.include? letter
		  return false
    end
    
    if @word.include? letter
  		@guesses = @guesses + letter
  	  return true
  	else
  	  @wrong_guesses = @wrong_guesses + letter
  	  return true
  	end
  end
  
  def word_with_guesses
  	result = ""
    
    # for each letter in word
    @word.each_char do |letter| 
     # if the letter is contained within @guesses
     if @guesses.include? letter
       result.concat letter
     else
       result.concat '-'
     end
    end
    
    return result
  end
  
  def check_win_or_lose
	  if @wrong_guesses.length >= 7
		  return :lose
	  end
	
	  if word_with_guesses == @word
		  return :win
	  end
	
	  :play
  end

end
