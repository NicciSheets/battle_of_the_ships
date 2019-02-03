require 'sinatra'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
require_relative 'board_class.rb'
require_relative 'game_class_app.rb'
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
	@game = Game.new()

	# @player1 = Player.new(player, difficulty)
	@opponent = @opponent || ""
	@player1 = @player1 || ""

	erb :game_play, locals: {difficulty: difficulty, player: player, game: @game, opponent: @opponent, player1: @player1}
end

post '/game_play' do
	p "params in game play are #{params}"
	difficulty = params[:difficulty] || ""
	# @player1 = @player1 || ""
	# @opponent = @opponent || ""
	@game = params[:game] || ""
	player = params[:player] || ""

	redirect '/game_play?difficulty=' + difficulty + '&game=' + @game + '&player=' + player
end
