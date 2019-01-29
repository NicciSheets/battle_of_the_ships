require_relative "board_class.rb"


class Game

	attr_reader :player, :opponent

# asks player to choose difficulty of beginner, intermediate or advanced
	def set_player
		player = ""
		while player.empty? do
			print "Player 1: Please enter your name: "
			player = gets.chomp
			@player = player.strip.capitalize
			if player == ""
				player = ""
			end
		end
		@player
	end

	def set_difficulty
		difficulty = ""
		while difficulty.empty? do 
			print "Welcome to Battleship Console, #{@player}! Please choose a difficulty level: [b]Beginner; [i]Intermediate; [a]Advanced: "
			difficulty = gets.chomp
			if difficulty.strip.downcase == "b" || difficulty.strip.downcase == "beginner"
				@difficulty = :beginner
			elsif difficulty.strip.downcase == "i" || difficulty.strip.downcase == "intermediate"
				@difficulty = :intermediate
			elsif difficulty.strip.downcase == "a" || difficulty.strip.downcase == "advanced"
				@difficulty = :advanced
			else
				difficulty = ""
			end
		end
		@difficulty
		puts
	end

	def set_player_board
		difficulty = @difficulty
		@player_board = Board.new(difficulty)
	end

	def show_player_board
		board_layout = @player_board.show_ships
		row_label = @player_board.grid_column
		column_label = @player_board.grid_row
		puts
		print "#{@player}'s Board:"
		puts
		puts
		print "\t"
		print row_label.join("\t")
		puts
		board_layout.each_with_index do |row, i|
  			print " #{column_label[i]}"
 			print "\t"
  			print row.join("\t")
  			puts
  		end
  		puts
  		puts
	end

	def set_opponent
		@opponent = "Enemy"
		print "Begin Game: #{@player} VS #{@opponent}, #{@difficulty.capitalize} Level."
		puts
		puts
	end

	def setup_player1
		print "Each board will be set up like the following:"
		puts
		self.show_player_board
		# self.pretty_show
		print "Four ships (Destroyer, Submarine, Cruiser and Battleship) will be placed on the board.  Ships may only be placed horizontally or vertically, never diagonally, and ships may not overlap board coordinates with one another."
		puts
	end

	def player1_add_ships(ship)
		ship_length = Ship::SHIP_INFO[ship]
		reply_direction = ""
		while reply_direction.empty? do
			print "Would you like to place your #{ship.capitalize} ship [h]Horizontally or [v]Vertically? "
			reply_direction = gets.chomp
			if reply_direction.strip.downcase == "h" || reply_direction.strip.downcase == "horizontally" || reply_direction.strip.downcase == "horizontal"
				@reply_direction = :horizontal
			elsif reply_direction.strip.downcase == "v" || reply_direction.strip.downcase == "vertically" || reply_direction.strip.downcase == "vertical"
				@reply_direction = :vertical
			else
				reply_direction = ""
			end
		end
		@reply_direction
		reply_row = ""
		while reply_row.empty? do
			print "What Row would you like to place your #{ship.capitalize} ship? " 
			reply_row = gets.chomp
			if @player_board.grid_row.include?(reply_row.strip.upcase) == true
				@reply_row = reply_row.strip.upcase
			else
				reply_row = ""
			end
		end
		@reply_row
		reply_column = ""
		while reply_column.empty? do
			print "What Column would you like to place your #{ship.capitalize} ship? " 
			reply_column = gets.chomp
			if @player_board.grid_column.include?(reply_column.strip) == true
				@reply_column = reply_column.strip
			else
				reply_column = ""
			end
		end
		@reply_column
		if @reply_direction == :horizontal
			rows = []
			columns = []
			count = 0
			ship_length.times do 
				rows << @reply_row
				columns << (@reply_column.to_i + count).to_s
				count += 1
			end
			rows
			columns
			cells = rows.zip(columns)
		else @reply_direction == :vertical
			rows = []
			columns = []
			count = 0
			ship_length.times do
				rows << Board::ROW[(Board::ROW.index(@reply_row) + count)]
				columns << @reply_column
				count += 1
			end
			rows
			columns
			cells = rows.zip(columns)
		end
		# p "cells are #{cells}""
		cells
		if @player_board.place((Ship.new(ship)), cells) != "Invalid Coordinates"
			@player_board.place((Ship.new(ship)), cells)
			self.show_player_board
		end
	end

	def place_opponent_ships
		ships = Ship::SHIP_INFO.keys
		
		difficulty = @difficulty
		@opponent_board = Board.new(difficulty)
		ships.reverse.each do |type|
			ship_length = Ship::SHIP_INFO[type]
			# valid = false
			# while valid == false do
				orientation = [:horizontal, :vertical].sample
				starting_coord = @opponent_board.coordinates.sample
				p "orientation is #{orientation} and starting_coord = #{starting_coord}"
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
				p cells
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
				p cells
			end
			cells
			redo if @opponent_board.place((Ship.new(type)), cells) == "Invalid Placement"

			if @opponent_board.place((Ship.new(type)), cells) != "Invalid Placement"
				# valid = true
				@opponent_board.place((Ship.new(type)), cells)
			end
		end
	end

# opponent's board console ready
	def show_opponent_board
		# board_layout = @opponent_board.no_show_ships
		board_layout = @opponent_board.show_ships
		row_label = @opponent_board.grid_column
		column_label = @opponent_board.grid_row
		puts
		print "#{@opponent}'s Board:"
		puts
		puts
		print "\t"
		print row_label.join("\t")
		puts
		board_layout.each_with_index do |row, i|
  			print " #{column_label[i]}"
 			print "\t"
  			print row.join("\t")
  			puts
  		end
  		puts
  		puts
  	end


end

			
			
					

game = Game.new()
game.set_player
game.set_difficulty
game.set_player_board
game.set_opponent
game.setup_player1
# game.player1_add_ships(:destroyer)
# game.player1_add_ships(:submarine)
# game.player1_add_ships(:cruiser)
# game.player1_add_ships(:battleship)
game.place_opponent_ships
game.show_opponent_board



