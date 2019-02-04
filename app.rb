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

	redirect '/board_setup?difficulty=' + difficulty + '&player=' + player
end

get '/board_setup' do
	difficulty = params[:difficulty].to_sym
	player = params[:player]
	@game = Game.new()
	@player1 = @game.player1(player, difficulty)
	@opponent = @game.opponent(player, difficulty)
	# @player1 = Player.new(player, difficulty)
	# @opponent = @opponent || ""
	# @player1 = @player1 || ""
	p "#{params} in board_setup"
	erb :board_setup, locals: {difficulty: difficulty, player: player}
end

