require 'sinatra'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
require_relative 'board_class.rb'
# require_relative 'game_class_app.rb'
enable :sessions

get '/' do
  erb :start_page
end

post '/start_page' do
	p "params in start page are #{params}"
	difficulty = params[:difficulty]
	player = params[:player]

	redirect '/game_play?difficulty=' + difficulty + '&player=' + player
end

get '/game_play' do
	difficulty = params[:difficulty].to_sym
	player = params[:player]
	col = params[:col]
	@player1 = Player.new(player, difficulty)
	@opponent = Player.new("Enemy", difficulty)
	
	erb :game_play, locals: {difficulty: difficulty, player: player, player1: @player1, opponent: @opponent, col: col}
end

post '/game_play' do
	p "params in game play are #{params}"
	difficulty = params[:difficulty]
	@player1 = @player1 || ""
	@opponent = @opponent || ""

	redirect '/game_play?player1=' + @player1 + '&difficulty=' + difficulty + '&opponent=' + @opponent 
end
