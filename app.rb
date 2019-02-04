require 'sinatra'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
require_relative 'board_class.rb'
require_relative 'game_class_app.rb'
enable :sessions

@@game = Game.new

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
	@game = @@game
	@player1 = @game.player1(player, difficulty)
	@opponent = @game.opponent(player, difficulty)

	orientation = params[:orientation]

	p "#{params} in board_setup"
	erb :board_setup, locals: {difficulty: difficulty, player: player, orientation: orientation}
end

