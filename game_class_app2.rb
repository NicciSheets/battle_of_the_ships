require_relative 'player_class.rb'

class Game

	attr_accessor :player1_ships, :new_player, :opponent, :opponent_ships, :players

	def initialize
		@player1_ships = []
		@opponent_ships = []
		@players = []
	end

	def add_player(player, difficulty)
		@new_player = Player.new(player, difficulty)	
		@player1_ships << @new_player.destroyer << @new_player.submarine << @new_player.cruiser << @new_player.battleship
		@players << @new_player
		@new_player
	end

	def add_opponent(player, difficulty)
		@opponent = Player.new("Enemy", difficulty)
		@opponent_ships << @opponent.destroyer << @opponent.submarine << @opponent.cruiser << @opponent.battleship
		@players << @opponent
		@opponent
	end

	def player1_name
		@new_player.player
	end

	def ship_to_place
		player1_ships.first
	end

	def opponent_name
		@opponent.player
	end
	
	def place_ship(start_cell, orientation)
		row = start_cell[0]
		column = start_cell[1]
		ship = ship_to_place
		valid = false
		while valid == false do
			ship_length = ship.length
			if orientation == "horizontal"
				rows = []
				columns = []
				count = 0
				ship_length.times do 
					rows << row
					columns << (column.to_i + count).to_s
					count += 1
				end
				rows
				columns
				cells = rows.zip(columns)
			else orientation == "vertical"
				rows = []
				columns = []
				count = 0
				ship_length.times do
					rows << Board::ROW[(Board::ROW.index(row) + count)]
					columns << column
					count += 1
				end
				rows
				columns
				cells = rows.zip(columns)
			end
			cells

			redo if @new_player.board.valid_placement?(ship, cells) == false
			
			status_arr = []
			cells.each do |row, column|
				status_arr << @new_player.board.cell_coordinates(row, column).status
			end
			status_arr
			
			redo if status_arr.uniq != ["."]
			
			if @new_player.board.valid_placement?(ship, cells) && status_arr.uniq == ["."]
				@new_player.board.place(ship, cells)
				@new_player.board.grid
				valid = true
			end
		end
	end

	def remove_placed_ship
		player1_ships.shift
	end	
	
	def place_opponent_ships
		ships = @opponent_ships
		valid = false
		while valid == false do
			ships.each do |ship|
				ship_length = ship.length
				opp_orientation = [:horizontal, :vertical].sample
				opp_start_cell2 = @opponent.coordinates_to_play.sample
				# p "orientation is #{orientation} and starting_coord = #{starting_coord}"
				if opp_orientation == "horizontal"
					opp_rows2 = []
					opp_columns2 = []
					count = 0
					ship_length.times do 
						opp_rows2 << opp_start_cell2[0]
						opp_columns2 << (opp_start_cell2[1].to_i + count).to_s
						count += 1
					end
					opp_rows2
					opp_columns2
					cells = opp_rows2.zip(opp_columns2)
					p cells
				else opp_orientation == "vertical"
					opp_rows2 = []
					opp_columns2 = []
					count = 0
					ship_length.times do
						opp_rows2 << Board::ROW[(Board::ROW.index(opp_start_cell2[0]) + count)]
						opp_columns2 << opp_start_cell2[1]
						count += 1
					end
					opp_rows2
					opp_columns2
					cells = opp_rows2.zip(opp_columns2)
					p cells
				end
				cells

				redo if @opponent.board.valid_placement?(ship, cells) ==  false

				status_arr = []
				cells.each do |row, column|
					status_arr << @opponent.board.cell_coordinates(row, column).status
				end
				status_arr

				redo if status_arr.uniq != ["."]

				if @opponent.board.valid_placement?(ship, cells) && status_arr.uniq	== ["."]
					@opponent.board.place(ship, cells)
					@opponent.board.grid
				valid =  true
				end
			end
		end
	end
# the ( ||= ) behaves like ( a || a = b ) ..... sets the value of turn as player1
	def turn
		@turn ||= @players.last.player
	end
# alias is working as a method that is giving the above method :turn another way to be called, which is as :current_player ..... 
	alias :current_player :turn
# says if the current turn is by the first player (player1), then when you call switch_turns, it gives Enemy player the turn, otherwise, it's player1's turn (because turn != player1, but is instead enemy's turn)
	def switch_turns
		if turn == players.last.player
			turn = players.first.player
		else
			turn = players.last.player
		end
	end

	
end

# need to add opponent AFTER putting player1 ships on board, so don't have to do much to the @ships code work
# game = Game.new
 # game.add_player("Nicci", :beginner)
 # game.add_opponent("Enemy", :beginner)
 # game.new_player
 # game.both_players_array
# p game.both_players_array.first.player
# p game.player1_name
# p game.opponent_name
# p game.player1_ships
# p game.ship_to_place
# p game.remove_placed_ship
# p game.ship_to_place
# p game.players[0].player
# p game.players.
# p game.new_player
# p game.turn
# p game.current_player
# p game.switch_turns
# p game.turn


