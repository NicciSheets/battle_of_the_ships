require_relative 'player_class.rb'

class Game

	attr_accessor :player1_ships, :new_player, :opponent, :opponent_ships

	def initialize
		@player1_ships = []
		@opponent_ships = []
	# 	@players = []
	end


	def add_player(player, difficulty)
		@new_player = Player.new(player, difficulty)	
		@player1_ships << @new_player.destroyer << @new_player.submarine << @new_player.cruiser << @new_player.battleship
		@new_player
	end

	def add_opponent(player, difficulty)
		@opponent = Player.new("Enemy", difficulty)
		@opponent_ships << @opponent.battleship << @opponent.cruiser << @opponent.submarine << @opponent.destroyer
		@opponent
	end

	def player1_name
		new_player.player
	end

	def ship_to_place
		player1_ships.first
	end

	def opponent_name
		opponent.player
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

	def show_player1_board
		new_player.board.grid
	end
	
	


	

end

# need to add opponent AFTER putting player1 ships on board, so don't have to do much to the @ships code work
# game = Game.new
 # game.add_player("Nicci", :beginner)
 # game.new_player
# p game.player1_name
# p game.player1_ships
# game.add_opponent("Enemy", :beginner)
# p game.ship_to_place
# p game.remove_placed_ship
# p game.ship_to_place
# p game.players[0].player
# p game.players.
# p game.new_player

