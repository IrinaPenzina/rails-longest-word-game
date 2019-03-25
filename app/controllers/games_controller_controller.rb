require 'open-uri'
require 'json'

class GamesControllerController < ApplicationController
  def new
    @letters = ('A'...'Z').to_a.sample(10)
  end

  def score
    word = params[:word]
    letters = params[:letters]

    @array_attempt = word.upcase.split('')

    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    open_url = open(url).read
    word_check = JSON.parse(open_url)

    @not_english = "Sorry but #{word} does not seem to be a valid English word..." unless word_check['found']

    @grid_not_grid = "Sorry but #{word} can't be built out of #{letters}" unless @array_attempt.uniq.all? {|letter| letters.count(letter) >= @array_attempt.count(letter)}

    if !@not_english && !@grid_not_grid
      @result = "Congratulations! #{word} is a valid English word!"
    end
  end
end
