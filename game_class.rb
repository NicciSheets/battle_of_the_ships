require_relative "player_class.rb"
require_relative "ship_class.rb"
class Game

	attr_reader :player, :opponent
# asks player to choose difficulty of beginner, intermediate or advanced
	def set_difficulty
		difficulty = ""
		if difficulty.empty?
			print "Please choose a difficulty level: (b)Beginner; (i)Intermediate; (a)Advanced: "
			difficulty = gets.chomp
			if difficulty == ""
				print "Please choose a valid difficulty level: (b)Beginner; (i)Intermediate; (a)Advanced: "
				difficulty = gets.chomp
				if difficulty.downcase == "b" || difficulty.downcase == "beginner"
					@difficulty = :beginner
				elsif difficulty.downcase == "i" || difficulty.downcase == "intermediate"
					@difficulty = :intermediate
				else difficulty.downcase == "a" || difficulty.downcase == "advanced"
					@difficulty = :advanced
				end
			else
				if difficulty.downcase == "b" || difficulty.downcase == "beginner"
					@difficulty = :beginner
				elsif difficulty.downcase == "i" || difficulty.downcase == "intermediate"
					@difficulty = :intermediate
				else difficulty.downcase == "a" || difficulty.downcase == "advanced"
					@difficulty = :advanced
				end
			end
		end
	end
				
# asks player1 to enter their name and sets @player
	def set_player
		player = ""
		if player.empty?
			print "Player 1: Please enter your name: "
			player = gets.chomp
			if player == ""
				print "Player 1: Please enter a valid name: "
				player = gets.chomp
			end
			difficulty = @difficulty
			@player = Player.new(player, difficulty)
		end
	end

#creates the opponent player with same difficulty as the player1 chooses
	def create_opponent
		difficulty = @difficulty
		@opponent = Player.new("opponent", difficulty)
	end

# this changes coordinates that are entered with row and column together (ie, "A2" or "AA12") and returns a cell_coordinates array of the row and column (ie, ["A", "2"] or ["AA", "12"]) 
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
				else
					coordinates[1] == coordinates[2]
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

	
	def opponent_horizontal_cells(type)
		coordinates = self.opponent.board.coordinates.sample
		beginning_coord = coordinates2array(coordinates)
		rows = []
		columns = []
		ship_length = Ship::SHIP_INFO[type]
		# p "ship_length is #{ship_length} and class is #{ship_length.class}"
		count = 0
		ship_length.times do
			rows << beginning_coord[0]
			columns << (beginning_coord[1].to_i + count).to_s
			count += 1
		end
		rows
		columns
		rows.zip(columns)
	end

	def opponent_vertical_cells(type)
		coordinates = self.opponent.board.coordinates.sample
		beginning_coord = coordinates2array(coordinates)
		rows = []
		columns = []
		ship_length = Ship::SHIP_INFO[type]
		# p "ship_length is #{ship_length} and class is #{ship_length.class}"
		count = 0
		ship_length.times do
			rows << Board::ROW[beginning_coord[0].to_i + count].to_s
			columns << beginning_coord[1]
			count += 1
		end
		rows
		columns
		rows.zip(columns)
	end

	def deploy_opponent_battleship1
		cells = []
		orientation = [:horizontal, :vertical].sample
		p "battleship orientation is #{orientation}"
		if orientation == :horizontal
			cells = opponent_horizontal_cells(:battleship)
		else orientation == :vertical
			cells = opponent_vertical_cells(:battleship)
		end
		p cells
	end

	def deploy_opponent_battleship2
		1.times do
			cells = self.deploy_opponent_battleship1
			if @opponent.board.valid_placement?(self.opponent.battleship, cells) == true
						@opponent.board.place(self.opponent.battleship, cells)
			end
			redo if @opponent.board.valid_placement?(self.opponent.battleship, cells) == false
		end
	end


	def deploy_opponent_cruiser1
		cells = []
		orientation = [:horizontal, :vertical].sample
		p "cruiser orientation is #{orientation}"
		if orientation == :horizontal
			cells = opponent_horizontal_cells(:cruiser)
		else orientation == :vertical
			cells = opponent_vertical_cells(:cruiser)
		end
		p cells
	end

	def deploy_opponent_cruiser2
		1.times do
			cells = self.deploy_opponent_cruiser1
			if @opponent.board.valid_placement?(self.opponent.cruiser, cells) == true
						@opponent.board.place(self.opponent.cruiser, cells)
			end
			redo if @opponent.board.valid_placement?(self.opponent.cruiser, cells) == false
		end
	end

	def deploy_opponent_submarine1
		cells = []
		orientation = [:horizontal, :vertical].sample
		p "submarine orientation is #{orientation}"
		if orientation == :horizontal
			cells = opponent_horizontal_cells(:submarine)
		else orientation == :vertical
			cells = opponent_vertical_cells(:submarine)
		end
		p cells
	end	

	def deploy_opponent_submarine2
		1.times do
			cells = self.deploy_opponent_submarine1
			if @opponent.board.valid_placement?(self.opponent.submarine, cells) == true
				@opponent.board.place(self.opponent.submarine, cells)
			end
			redo if @opponent.board.valid_placement?(self.opponent.submarine, cells) == false
		end
	end

	def deploy_opponent_destroyer1
		cells = []
		orientation = [:horizontal, :vertical].sample
		p "destroyer orientation is #{orientation}"
		if orientation == :horizontal
			cells = opponent_horizontal_cells(:destroyer)
		else orientation == :vertical
			cells = opponent_vertical_cells(:destroyer)
		end
		p cells
	end

	def deploy_opponent_destroyer2
		1.times do
			cells = self.deploy_opponent_destroyer1
			if @opponent.board.valid_placement?(self.opponent.destroyer, cells) == true
				@opponent.board.place(self.opponent.destroyer, cells)
			end
			redo if @opponent.board.valid_placement?(self.opponent.destroyer, cells) == false
		end
	end

	def deploy_opponent_ships
		1.times do
			cells4 = self.deploy_opponent_destroyer
			if @opponent.board.valid_placement?(self.opponent.destroyer, cells4) == true
				@opponent.board.place(self.opponent.destroyer, cells4)
			end
			redo if @opponent.board.valid_placement?(self.opponent.destroyer, cells4) == false
			1.times do
				cells = self.deploy_opponent_submarine
				if @opponent.board.valid_placement?(self.opponent.submarine, cells) == true
					@opponent.board.place(self.opponent.submarine, cells)
				end
				redo if @opponent.board.valid_placement?(self.opponent.submarine, cells) == false
				1.times do
					cells2 = self.deploy_opponent_cruiser
					if @opponent.board.valid_placement?(self.opponent.cruiser, cells2) == true
						@opponent.board.place(self.opponent.cruiser, cells2)
					end
					redo if @opponent.board.valid_placement?(self.opponent.cruiser, cells2) == false
					1.times do
					cells3 = self.deploy_opponent_battleship
					if @opponent.board.valid_placement?(self.opponent.battleship, cells3) == true
						@opponent.board.place(self.opponent.battleship, cells3)
					end
					redo if @opponent.board.valid_placement?(self.opponent.battleship, cells3) == false
				end
				end
			end
		end
	end

	def game_grids
		# @opponent.pretty_no_show
		@player.pretty_show
		@opponent.pretty_show
	end
		
	def deploy_opp_ships
	# position = {}
	cells = []
	Ship::SHIP_INFO.keys.each do |type|
		p "type is #{type}"
		# valid = false
		# if valid == false
		orientation = [:horizontal, :vertical].sample
			# p "orientation is #{orientation}"
		if orientation == :horizontal
			cell = opponent_horizontal_cells(type)
		else
			cell = opponent_vertical_cells(type)
		end
		cell
		redo if @opponent.board.valid_placement?(ship=type, cell) == false
		end
		cells << cell
		p cells
		cells.each do 
			case ship=type
			when :battleship
				while @opponent.board.place(self.opponent.battleship, cells[0]) == "Invalid Coordinates"
					@opponent.board.place(self.opponent.battleship, cells[0])	
				end
			when :cruiser
			 	while @opponent.board.place(self.opponent.cruiser, cells[1]) == "Invalid Coordinates"
			 		@opponent.board.place(self.opponent.cruiser, cells[1])
				end
			when :submarine
			 	while @opponent.board.place(self.opponent.submarine, cells[2]) == "Invalid Coordinates"
			 		@opponent.board.place(self.opponent.submarine, cells[2]) 
				end
			when :destroyer
			 	while @opponent.board.place(self.opponent.destroyer, cells[3]) == "Invalid Coordinates"
			 		@opponent.board.place(self.opponent.destroyer, cells[3])
			 	end
			 end
			end
		end
		@opponent.board
	end
		# 		 end
		# 		
			# 	if @opponent.board.valid_placement?(ship=type, cells) ==  true
			# 		@opponent.board.place(self.opponent.ship, cells)
			# 	end
			# 	# cell << cells				
			# else
			# 	cells = opponent_vertical_cells(type)
			# 	if @opponent.board.valid_placement?(ship=type, cells) ==  true
			# 		@opponent.board.place(self.opponent.ship, cells)
			# 	end
				# cell << cells
			# end
			# p "cell.uniq is #{cell.uniq}"
		# cell
		# @opponent.board
		
	# end
		# if @opponent.board.valid_placement?(ship=type, cells) == true				 
		# 	# valid = true
		# 	# if valid == true
		# 	case ship
		# 		when :battleship
		# 			@opponent.board.place(self.opponent.battleship, cells)
		# 		when @opponent.carrier.type
		# 		 	@opponent.board.place(self.opponent.carrier, cells)
		# 		when @opponent.submarine.type
		# 		 	@opponent.board.place(self.opponent.submarine, cells)
		# 		when @opponent.destroyer.type
		# 		 	@opponent.board.place(self.opponent.destroyer, cells)
		# 		 end
		# 		end
		# 		redo if @opponent.board.valid_placement?(ship=type, cells) == false
		# 	end
		
		# end

		
		def ready_set_go
			self.set_difficulty
			self.set_player
			self.create_opponent

			# deploy_opponent_destroyer2
			# @opponent.board
			# deploy_opponent_submarine2
			# @opponent.board
			# deploy_opponent_cruiser2
			# @opponent.board
			# deploy_opponent_battleship2
			# @opponent.board
			# @opponent.pretty_show
			self.deploy_opp_ships
			self.game_grids
		end

end

p game = Game.new()
# game.set_difficulty
# game.set_player
# game.create_opponent
# p game.opponent.destroyer.type
# game.player.pretty_show
# game.opponent.pretty_no_show
# p game.opponent.board.grid_size
# game.player.board.place(game.player.cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# game.player.board.place(game.player.battleship, [["B", "1"], ["C", "1"]])
# game.opponent.board.place(game.opponent.cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# game.player.pretty_show
# game.opponent.pretty_no_show
# p game.player.board.cell_coordinates("A", "1").status
# p game.opponent.board.cell_coordinates("A", "1").status
# game.deploy_opponent_ships
# p game.opponent_horizontal_cells(:submarine)
# game.opponent.pretty_show
game.ready_set_go