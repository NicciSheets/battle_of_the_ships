require 'sinatra'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
require_relative 'board_class.rb'
# require_relative 'game_class.rb'
enable :sessions

get '/' do
	
  erb :start_page
end

post '/start_page' do
	p "params in start page are #{params}"
	difficulty = params[:difficulty]
	player1 = params[:player1]
	redirect '/game_play?difficulty=' + difficulty + '&player1=' + player1
end

get '/game_play' do
	difficulty = params[:difficulty].to_sym
	player1 = params[:player1]
	@player1 = Player.new(player1, difficulty)
	@opponent = Player.new("Enemy", difficulty)
	erb :game_play, locals: {difficulty: difficulty, player1: player1}
end

post '/game_play' do
	p "params in game play are #{params}"
	difficulty = params[:difficulty]
	player1 = params[:player1]
	# @player1 = Player.new(player1, difficulty)
	# @opponent = Player.new("Enemy", difficulty)
	
	redirect '/game_play?player1=' + player1 + '&difficulty=' + difficulty
end
