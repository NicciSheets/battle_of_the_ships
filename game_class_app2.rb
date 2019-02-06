require_relative 'player_class.rb'

class Game

	attr_accessor :ships, :new_player

	def initialize
		@ships = []
	# 	@players = []
	end


	def add_player(player, difficulty)
		@new_player = Player.new(player, difficulty)	
		@ships << @new_player.battleship << @new_player.cruiser << @new_player.submarine << @new_player.destroyer
		@new_player
		# @new_player.board
		# @new_player.player
		
	end

	def player1_name
		new_player.player
	end

	def ship_to_place
		ships.first
	end
	
	# def ship_empty?
	# 	ship_to_place.empty?
	# end

	def place_ship(start_cell, orientation)
		row = start_cell[0]
		column = start_cell[1]
		ship = ship_to_place
		valid = false
		while valid == false do
		# ships.each do |ship|
		ship_length = ship.length
			# row = ""
			# while row.empty? do
			# if @new_player.board.grid_row.include?(row.strip.upcase) == true
			# 	row = reply_row.strip.upcase
			# else				
			# 	"Invalid Coordinate"
			# end
			# row
			# 	# column = ""
			# 	# while column.empty? do
			# if @new_player.board.grid_column.include?(column.strip) == true
			# 	column = column.strip
			# 	else
			# 		"Invalid Coordinate"
			# end
			# column
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
		ships.shift
	end

	
	def add_opponent(player, difficulty)
		opponent = Player.new("Enemy", difficulty)
		@players << opponent
		opponent.board
		opponent.player
		@ships << opponent.battleship << opponent.cruiser << opponent.submarine << opponent.destroyer
	end


	

end

# need to add opponent AFTER putting player1 ships on board, so don't have to do much to the @ships code work
# game = Game.new
 # game.add_player("Nicci", :beginner)
 # game.new_player
# p game.player1_name
# p game.ships
# game.add_opponent("Enemy", :beginner)
# p game.ship_to_place
# p game.remove_placed_ship
# p game.ship_to_place
# p game.players[0].player
# p game.players.
# p game.new_player

