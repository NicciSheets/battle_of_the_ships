require_relative "board_class.rb"
require_relative "player_class.rb"


class Game

	attr_reader :player, :opponent, :targeting_queue


	def player1(player, difficulty)
		difficulty
		player
		Player.new(player, difficulty)
	end

	def opponent(player, difficulty)
		difficulty 
		player = "Enemy"
		Player.new(player, difficulty)
	end

	def place_opponent_ships(player, difficulty)
		@opponent = self.opponent(player, difficulty)
		ships = ships = [@opponent.destroyer, @opponent.submarine, @opponent.cruiser, @opponent.battleship]
		valid = false
		while valid == false do
			ships.each do |ship|
				ship_length = ship.length
					orientation = [:horizontal, :vertical].sample
					starting_coord = @opponent.coordinates_to_play.sample
					# p "orientation is #{orientation} and starting_coord = #{starting_coord}"
					if orientation == :horizontal
						rows = []
						columns = []
						count = 0
						ship_length.times do 
						rows << starting_coord[0]
						columns << (starting_coord[1].to_i + count).to_s
						count += 1
					end
					rows
					columns
					cells = rows.zip(columns)
					# p cells
				else orientation == :vertical
					rows = []
					columns = []
					count = 0
					ship_length.times do
						rows << Board::ROW[(Board::ROW.index(starting_coord[0]) + count)]
						columns << starting_coord[1]
						count += 1
					end
					rows
					columns
					cells = rows.zip(columns)
					# p cells
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
					valid = true
				end
			end
		end
		@opponent.board.grid
	end

	def player1_add_ships(player, difficulty)
		@player1 = self.player1(player, difficulty)
		valid = false
		while valid == false do
			ships = [@player1.destroyer, @player1.submarine, @player1.cruiser, @player1.battleship]
			ships.each do |ship|
				ship_length = ship.length
				orientation = orientation
				app_orientation = ""
				if orientation == "horizontal"
					app_orientation = :horizontal
				else 
					app_orientation = :vertical
				end
				app_orientation

			end
		end
	end
	# 			reply_row = ""
	# 			while reply_row.empty? do
	# 				print "What Row would you like to place your #{ship.type.capitalize} ship? " 
	# 				reply_row = gets.chomp
	# 				if @player1.board.grid_row.include?(reply_row.strip.upcase) == true
	# 					reply_row = reply_row.strip.upcase
	# 				else				
	# 					reply_row = ""
	# 				end
	# 			end
	# 			reply_row
	# 			reply_column = ""
	# 			while reply_column.empty? do
	# 				print "What Column would you like to place your #{ship.type.capitalize} ship? " 
	# 				reply_column = gets.chomp
	# 				if @player1.board.grid_column.include?(reply_column.strip) == true
	# 					reply_column = reply_column.strip
	# 				else
	# 					reply_column = ""
	# 				end
	# 			end
	# 			reply_column
	# 			if reply_direction == :horizontal
	# 				rows = []
	# 				columns = []
	# 				count = 0
	# 				ship_length.times do 
	# 					rows << reply_row
	# 					columns << (reply_column.to_i + count).to_s
	# 					count += 1
	# 				end
	# 				rows
	# 				columns
	# 				cells = rows.zip(columns)
	# 			else reply_direction == :vertical
	# 				rows = []
	# 				columns = []
	# 				count = 0
	# 				ship_length.times do
	# 					rows << Board::ROW[(Board::ROW.index(reply_row) + count)]
	# 					columns << reply_column
	# 					count += 1
	# 				end
	# 				rows
	# 				columns
	# 				cells = rows.zip(columns)
	# 			end
	# 			cells

	# 			redo if @player1.board.valid_placement?(ship, cells) == false
			
	# 			status_arr = []
	# 			cells.each do |row, column|
	# 				status_arr << @player1.board.cell_coordinates(row, column).status
	# 			end
	# 			status_arr
			
	# 			redo if status_arr.uniq != ["."]
			
	# 			if @player1.board.valid_placement?(ship, cells) && status_arr.uniq == ["."]
	# 				@player1.board.place(ship, cells)
	# 				@player1.show_player_board
	# 				valid = true
	# 			end
	# 		end
	# 	end
	# end

	
# asks player1 for coordinates to fire upon and changes the status of that coordinate on enemy board with corresponding action and method
def player_round
	print "********** Your Turn! **********"
	puts
	puts
	valid = false
	while valid == false do
		input = ""
		while input.empty? do
			print "Please choose a coordinate to fire upon: "

			input = gets.chomp.gsub(/\s+/, "").upcase
		
			redo if input == "" 
			redo if input.length == 1

			coordinates = coordinates2array(input)

			redo if @opponent.board.grid_row.include?(coordinates[0]) == false
			redo if @opponent.board.grid_column.include?(coordinates[1]) == false
	
			valid = true
		end
		coordinates
		redo if @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status == "0"
		redo if @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status == "X"

		if @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status == "."
			system('cls')
			puts
			print "#{@player1} Missed!"
			puts
			puts
			@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).miss
		else
			valid = false
			if @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :battleship
				system('cls')
				@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit
				@opponent.battleship.hit
				puts
				print "#{@player1} Hit an Enemy Ship!"
				puts
				puts
				if 	@opponent.battleship.sunk?

					@opponent.ships_left -= 1
					print "Enemy Battleship Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					puts
				end
				self.show_boards
			elsif @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :cruiser
				system('cls')
				@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit				
				@opponent.cruiser.hit
				puts
				print "#{@player1} Hit an Enemy Ship!"
				puts
				puts
				if @opponent.cruiser.sunk?
					@opponent.ships_left -= 1
					print "Enemy Cruiser Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					puts
				end
				self.show_boards
			elsif @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :submarine
				system('cls')
				@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit
				@opponent.submarine.hit
				puts
				print "#{@player1} Hit an Enemy Ship!"
				puts
				puts
				if @opponent.submarine.sunk?
					@opponent.ships_left -= 1
					print "Enemy Submarine Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					puts
				end
				self.show_boards
			else @opponent.board.cell_coordinates(coordinates[0], coordinates[1]).status.type == :destroyer
				system('cls')
				@opponent.board.cell_coordinates(coordinates[0], coordinates[1]).hit
				@opponent.destroyer.hit
				puts
				print "#{@player1} Hit an Enemy Ship!"
				puts
				puts
				if @opponent.destroyer.sunk?
					@opponent.ships_left -= 1
					print "Enemy Destroyer Sunk! #{@opponent.ships_left} Enemy Ships Remaining!"
					puts
				end
				self.show_boards
				valid = true
			end
		end
	end
end
	
# changes the easily entered coordinate of A1 into "A, 1" for the program to read
def coordinates2array(coordinates)
		row = ""
		column = ""
		cell_coordinates = []
		if self.opponent.board.grid_size == 12 || self.opponent.board.grid_size == 24
			row << coordinates[0]
			if coordinates.length == 3
				column << coordinates[1] << coordinates[2]
			else
				column << coordinates[1]
			end
		else self.opponent.board.grid_size == 36
			if coordinates.length == 3
				if coordinates[0] == coordinates[1]
					row << coordinates[0] << coordinates[1]
					column << coordinates[2]
				else coordinates[1] == coordinates[2]
					row << coordinates[0] 
					column << coordinates[1] << coordinates[2]
				end
			elsif coordinates.length == 4
				row << coordinates[0] << coordinates[1]
				column << coordinates[2] << coordinates[3]
			else
				row << coordinates[0]
				column << coordinates[1]
			end
		end
		row
		column
		cell_coordinates << row << column
	end

	def opponent_round
		@targeting_queue = @opponent.coordinates_to_play.shuffle

		loop do
			puts
			print "********** Your Enemy's Turn **********"
			puts
			puts
			
			target_coords = @targeting_queue.pop 
			player1_coord = @player1.board.cell_coordinates(target_coords[0], target_coords[1])

			print "Your enemy has chosen coordinates #{target_coords.join} to fire upon!"
			puts
			puts
			if player1_coord.status == "."
				player1_coord.miss
				print "Miss!"
				puts
				break
			else
				print "Hit!"
				puts
				if player1_coord.status.type == :battleship
					player1_coord.hit
					@player1.battleship.hit
				elsif player1_coord.status.type == :cruiser
					player1_coord.hit
					@player1.cruiser.hit
				elsif player1_coord.status.type == :submarine
					player1_coord.hit
					@player1.submarine.hit
				else player1_coord.status.type == :destroyer
					player1_coord.hit
					@player1.destroyer.hit
					valid = true
				end
			end
		end
		puts
		print "********************"
	end
		

# alternates player1 and opponent turns
  	def play_rounds
  		self.show_boards
  		game_over = false
  		while game_over == false do
  			player_round
  			if @opponent.ships_left == 0 
  				winner = @player1
  				game_over = true
  				next
  			end

  			opponent_round
  			self.show_boards
  			if @player1.ships_left == 0
  				winner = @opponent
  				game_over = true
  			end
  		end
  		print "#{winner} Wins Battleship!!"
  	end

  
end


