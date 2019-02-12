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
	session[:logo] = true
	erb :register
end

get'/new_game' do
	session.clear
	game.player1_ships.clear
	game.opponent_ships.clear
	game.players.clear
	redirect '/'
end

post '/register' do
	p "params in register post are #{params}"
	game.add_opponent("Enemy", params[:difficulty].to_sym)
	player = params[:player].strip.capitalize
	game.add_player(player, params[:difficulty].to_sym)
	@opponent_name = game.opponent_name
	@grid_size = game.opponent.board.grid_size
	@opponent_grid = game.opponent.board.grid
	@grid_rows = game.opponent.board.grid_row
	@grid_columns = game.opponent.board.grid_column
	game.place_opponent_ships
	redirect '/place_ship'
end

get '/place_ship' do
	session[:placing_ships] = true
	session[:logo] =  false
	@player1_name = game.player1_name
	@grid_size = game.new_player.board.grid_size
	@player1_grid = game.new_player.board.grid
	@grid_rows = game.new_player.board.grid_row
	@grid_columns = game.new_player.board.grid_column
	
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
    	if game.place_ship(start_cell, orientation) == "Invalid Coordinates"
    		redirect '/place_ship'
    	else
    		game.place_ship(start_cell, orientation)
    	end
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
	@opponent_ships_left = game.opponent.ships_left

	@player1_name = game.player1_name
	erb :fire_shot
end

post '/shot_result' do
	session[:opponent_board_display] = true
	coordinates = []
	coordinates << params[:row] << params[:column]
	

	@opponent_name = game.opponent_name
	@grid_size = game.opponent.board.grid_size
	@opponent_grid = game.opponent.board.grid
	@grid_rows = game.opponent.board.grid_row
	@grid_columns = game.opponent.board.grid_column
	@opponent_ships_left = game.opponent.ships_left

	begin
		shot_result = game.player_round(coordinates)
		@shot_result1 = shot_result[0]
		@player1_shots_fired = shot_result[1]
		@opponent_ships_left = shot_result.last

	end
	erb :shot_result
end

get '/next_player_turn' do
	session[:opponent_board_display] =  false
	session[:placing_ships] =  true

	@player1_name = game.player1_name
	@grid_size = game.new_player.board.grid_size
	@player1_grid = game.new_player.board.grid
	@grid_rows = game.new_player.board.grid_row
	@grid_columns = game.new_player.board.grid_column
	@player1_ships_left = game.new_player.ships_left

	@opponent_name = game.opponent_name
	erb :next_player_turn
end

post '/opponent_result' do
	session[:opponent_board_display] =  false
	session[:placing_ships] =  true

	@player1_name = game.player1_name
	@grid_size = game.new_player.board.grid_size
	@player1_grid = game.new_player.board.grid
	@grid_rows = game.new_player.board.grid_row
	@grid_columns = game.new_player.board.grid_column
	@player1_ships_left = game.new_player.ships_left

	@opponent_name = game.opponent_name

	begin
		shot_result = game.opponent_turn
		@coordinates_fired_upon = shot_result[2]
		@opponent_shot_result = shot_result[0]
		@opponent_shots_fired = shot_result[1]
		@player1_ships_left = shot_result[3]
	end
	erb :opponent_result
end

get '/winner' do
	session[:opponent_board_display] =  false
	session[:placing_ships] =  false
	session[:logo] =  true

	winner = game.winner
	@winner = winner[0]
	@winner_shots_fired = winner[1]
	@loser_shots_fired = winner[2]
	@loser_name = winner[3]
	@winner_name = winner[4]
	erb :winner
end



