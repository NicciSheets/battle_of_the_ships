require 'sinatra'
require_relative 'ship_class.rb'
require_relative 'cell_class.rb'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
require_relative 'game_class_app2.rb'
enable :sessions

game = Game.new

get '/' do
	session[:grid_display], session[:placing_ships] = false
	erb :register
end

post '/register' do
	p "params in register post are #{params}"
	session[:difficulty] =  params[:difficulty]
	# game.add_opponent("Enemy", params[:difficulty].to_sym)
	game.add_player(params[:player], session[:difficulty].to_sym)
	redirect '/place_ship'
end

get '/place_ship' do
	session[:placing_ships] = true
	@player1_name = game.player1_name
	@player1_grid_size = game.new_player.board.grid_size		
    if game.ships.empty?
    	p "place_ship get params are #{params}"
    	erb :all_ships_placed
    else
        @ship = game.ship_to_place
        @ship_type = @ship.type.to_s.capitalize
        @ship_size = @ship.length
        p "place_ship get params are #{params}"
      	erb :place_ship
    end
end

post '/place_ship' do
	p "params in place ship post are #{params}"
	start_cell.to_a = "#{params[:row]}, #{params[:column]}"
    orientation = params[:orientation]
    begin
    	game.place_ship(start_cell, orientation)
    	game.remove_placed_ship
    rescue => error
   		flash[:notice] = error.to_s
    end
    redirect '/place_ship'
end

get '/ready_to_play' do
	game.add_opponent("Enemy", session[:difficulty].to_sym)
	erb :ready_to_play
end

