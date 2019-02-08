require 'sinatra'
require_relative 'ship_class.rb'
require_relative 'cell_class.rb'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
require_relative 'game_class_app2.rb'
enable :sessions

game = Game.new

get '/' do
	session[:opponent_board_display], session[:placing_ships] = false
	erb :register
end

get'/new_game' do
	game.player1_ships.clear
	game.opponent_ships.clear
	game.opponent.clear
	game.new_player.clear
	game.players.clear	
	redirect '/'
end

post '/register' do
	p "params in register post are #{params}"
	game.add_opponent("Enemy", params[:difficulty].to_sym)
	game.add_player(params[:player], params[:difficulty].to_sym)
	redirect '/place_ship'
end

get '/place_ship' do
	session[:placing_ships] = true
	@player1_name = game.player1_name
	@grid_size = game.new_player.board.grid_size
	@player1_grid = game.new_player.board.grid
	@grid_rows = game.new_player.board.grid_row
	@grid_columns = game.new_player.board.grid_column
	
	@current_player = game.current_player
	p "@current_player in place ship is #{@current_player}"
    if game.player1_ships.empty?
	    	erb :all_ships_placed
    else
        @ship = game.ship_to_place
        @ship_type = @ship.type.to_s.capitalize
        @ship_size = @ship.length
   	 	erb :place_ship
    end
end

post '/place_ship' do
	p "params in place ship post are #{params}"
	start_cell = []
	start_cell << params[:row] << params[:column]
	orientation = params[:orientation]

 	begin  
    	game.place_ship(start_cell, orientation)
    	game.remove_placed_ship
    end

    redirect '/place_ship'
end

get '/fire_shot' do
	session[:placing_ships] = false
	session[:opponent_board_display] = true
	@opponent_name = game.opponent_name
	@grid_size = game.opponent.board.grid_size
	@opponent_grid = game.opponent.board.grid
	@grid_rows = game.opponent.board.grid_row
	@grid_columns = game.opponent.board.grid_column
	game.place_opponent_ships

	@player1_name = game.player1_name

	@current_player = game.current_player
	erb :fire_shot
end

post '/shot_result' do
	session[:opponent_board_display] = true

	erb :shot_result
end



