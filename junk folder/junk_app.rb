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
	
	cell_coordinates = params[:cell_coordinates] || ""
	row = params[:row] || ""
	column = params[:column] || ""
	orientation = params[:orientation] || ""

	
	p "#{params} in board_setup"
	erb :board_setup, locals: {difficulty: difficulty, player: player, orientation: orientation, cell_coordinates: cell_coordinates, row: row, column: column}
end

post '/board_setup' do
	p "params in post board setup is #{params}"

	difficulty = params[:difficulty].to_sym || ""
	player = params[:player] || ""

	cell_coordinates = params[:cell_coordinates]
	row = params[:row] || ""
	column = params[:column] || ""
	orientation = params[:orientation] || ""

	redirect '/board_setup?difficulty=' + difficulty + '&player=' + player + '&cell_coordinates=' + cell_coordinates + '&row=' + row + '&column=' + column + '&orientation=' + orientation
end