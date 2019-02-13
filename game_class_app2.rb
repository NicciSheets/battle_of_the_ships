require_relative 'player_class.rb'

class Game

	attr_accessor :player1_ships, :new_player, :opponent, :opponent_ships

	def initialize
		@player1_ships = []
		@opponent_ships = []
	end

	def add_player(player, difficulty)
		@new_player = Player.new(player, difficulty)	
		@player1_ships << @new_player.destroyer << @new_player.submarine << @new_player.cruiser << @new_player.battleship
		@new_player
	end

	def add_opponent(player, difficulty)
		@opponent = Player.new("Enemy", difficulty)
		@opponent_ships << @opponent.destroyer << @opponent.submarine << @opponent.cruiser << @opponent.battleship
		@opponent
	end

	def player1_name
		@new_player.player
	end

	def opponent_name
		@opponent.player
	end

	def ship_to_place
		player1_ships.first
	end
	
	def place_ship(start_cell, orientation)
		row = start_cell[0]
		column = start_cell[1]
		ship = ship_to_place
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
			cells = rows.zip(columns)
		end
		cells
		
		status_arr = []
		if @new_player.board.valid_placement?(ship, cells) == false
			"Invalid Coordinates"
		else
			cells.each do |row, column|
				status_arr << @new_player.board.cell_coordinates(row, column).status
			end
			status_arr
			if status_arr.uniq != ["."]
				"Invalid Coordinates"
			else
				@new_player.board.place(ship, cells)
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
				opp_orientation = ["horizontal", "vertical"].sample
				opp_start_cell2 = @opponent.coordinates_to_play.sample
				if opp_orientation == "horizontal"
					opp_rows2 = []
					opp_columns2 = []
					count = 0
					ship_length.times do 
						opp_rows2 << opp_start_cell2[0]
						opp_columns2 << (opp_start_cell2[1].to_i + count).to_s
						count += 1
					end
					cells = opp_rows2.zip(opp_columns2)
				else opp_orientation == "vertical"
					opp_rows2 = []
					opp_columns2 = []
					count = 0
					ship_length.times do
						opp_rows2 << Board::ROW[(Board::ROW.index(opp_start_cell2[0]) + count)]
						opp_columns2 << opp_start_cell2[1]
						count += 1
					end
					cells = opp_rows2.zip(opp_columns2)
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

	def player_round(coordinates)
		available_coordinates = @opponent.coordinates_to_play

		shot_result = []
		if available_coordinates.include?(coordinates)
			if @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status == "."
				@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).miss
				shot_result << "Miss!"
			else
				if @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :battleship
					@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit
					@opponent.battleship.hit
					if 	@opponent.battleship.sunk?
						@opponent.ships_left -= 1
						shot_result << "Enemy Battleship Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					else
						shot_result << "Hit!"
					end
				elsif @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :cruiser
					@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit				
					@opponent.cruiser.hit
					if @opponent.cruiser.sunk?
						@opponent.ships_left -= 1
						shot_result << "Enemy Cruiser Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					else
						shot_result << "Hit!"
					end
				elsif @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :submarine
				@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit
					@opponent.submarine.hit
					if @opponent.submarine.sunk?
						@opponent.ships_left -= 1
						shot_result << "Enemy Submarine Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					else
						shot_result << "Hit!"
					end
				else @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :destroyer
					@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit
					@opponent.destroyer.hit
					if @opponent.destroyer.sunk?
						@opponent.ships_left -= 1
						shot_result << "Enemy Destroyer Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					else
						shot_result << "Hit!"
					end
				end
			end
		else
			shot_result << "Invalid Coordinates"
		end
		@opponent.ships_left
		@new_player.shots_fired += 1
		@opponent.coordinates_to_play.delete(coordinates)
		shot_result << @new_player.shots_fired << @opponent.ships_left
		shot_result
	end

	def opponent_turn
		shot_result = []

		target_coords = @new_player.coordinates_to_play.shuffle.pop 

		player1_coord = @new_player.board.cell_coordinates(target_coords[0], target_coords[1])

		if player1_coord.status == "."
				player1_coord.miss
				shot_result << "Miss!"
		else
			if player1_coord.status.type == :battleship
				player1_coord.hit
				@new_player.battleship.hit
				if @new_player.battleship.sunk?
					@new_player.ships_left -= 1
					shot_result << "Your Battleship Has Been Sunk! You Have #{@new_player.ships_left} Ships Remaining!"
				else
					shot_result << "Hit!"
				end
			elsif player1_coord.status.type == :cruiser
				player1_coord.hit
				@new_player.cruiser.hit
				if @new_player.cruiser.sunk?
					@new_player.ships_left -= 1
					shot_result << "Your Cruiser Has Been Sunk! You Have #{@new_player.ships_left} Ships Remaining!"
				else
					shot_result << "Hit!"
				end
			elsif player1_coord.status.type == :submarine
				player1_coord.hit
				@new_player.submarine.hit
				if @new_player.submarine.sunk?
					@new_player.ships_left -= 1
					shot_result << "Your Submarine Has Been Sunk! You Have #{@new_player.ships_left} Ships Remaining!"
				else
					shot_result << "Hit!"
				end
			else player1_coord.status.type == :destroyer
				player1_coord.hit
				@new_player.destroyer.hit
				if @new_player.destroyer.sunk?
					@new_player.ships_left -= 1
					shot_result << "Your Destroyer Has Been Sunk! You Have #{@new_player.ships_left} Ships Remaining!"
				else
					shot_result << "Hit!"
				end
			end
		end
		@new_player.coordinates_to_play.delete(target_coords)
		@new_player.ships_left
		@opponent.shots_fired += 1
		shot_result << @opponent.shots_fired << player1_coord << @new_player.ships_left
		shot_result
	end

	def winner
		winner = []
		if @opponent.ships_left == 0
			winner << "Congratulations! #{@new_player.player} is the Winner!" << @new_player.shots_fired << @opponent.shots_fired << @opponent.player << @new_player.player
		else @new_player.ships_left == 0
			winner << "Enemy Wins! Better Luck Next Time, #{@new_player.player}!" << @opponent.shots_fired << @new_player.shots_fired << @new_player.player << @opponent.player
		end
		winner
	end


end


cell = ["A", "36"]
public
def vertical_neighbors(cell)
	x = cell[0]
	y = cell[1].to_i
	[-1, 1].permutation(2).map do |dx, dy|
		[x, (y + dy).to_s]
	end
end

def vertical_valid?(cell)
	neighbors = vertical_neighbors(cell)
	neighbors.each do |x, y|
		if Board::COLUMN.include?(y)
			[x, y]
		else
			neighbors.delete([x, y])
		end
	end
end

def horizontal_neighbors(cell)
	x = cell[0]
	y = cell[1]
	neighbors = []
	[-1, 1].permutation(2).map do |dx, dy|
		xx = Board::ROW.index(cell[0])
		neighbors << [Board::ROW[xx + dx], y]
	end
	if x == Board::ROW.first
		neighbors.delete_at(0)
	elsif x == Board::ROW.last
		neighbors.delete_at(1)
	else
		neighbors
	end
	neighbors
end

# def horizontal_valid?(cell)
# 	neighbors = horizontal_neighbors(cell)
# 	p neighbors
# 	neighbors.each do |x, y|
# 		if x == ""
# 			[x,y]
# 		else
# 			neighbors.delete([x,y])
# 		end
# 	end
# end

# p vertical_neighbors(cell)
p vertical_valid?(cell)
p horizontal_neighbors(cell)
# p horizontal_valid?(cell)