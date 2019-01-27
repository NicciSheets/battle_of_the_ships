# require_relative "player_class.rb"
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
		# p "@player_board is #{@player_board}"
	end

	def show_player_board
		board_layout = @player_board.show_ships
		row_label = @player_board.grid_column
		column_label = @player_board.grid_row

		print "\t"
		print row_label.join("\t")
		puts
		board_layout.each_with_index do |row, i|
  			print column_label[i]
 			print "\t"
  			print row.join("\t")
  			puts
  		end
  		puts
	end

	def set_opponent
		@opponent = "Enemy"
		print "Begin Game: #{@player} VS #{@opponent}, #{@difficulty.capitalize} Level."
		puts
		puts
	end

	def setup_player
		print "Each board will be set up like the following:"
		puts
		self.show_player_board
		print "Four ships (Destroyer, Submarine, Cruiser and Battleship) will be placed on the board.  Ships may only be placed horizontally or vertically, never diagonally, and ships may not overlap board coordinates with one another."
		puts
		ships = {:destroyer => ["Destroyer", 5], :submarine => ["Submarine", 4], :cruiser => ["Cruiser", 3], :battleship => ["Battleship", 2]}
		ship_keys = ships.keys
		ships.values.each do |ship, units|
			while true
				print "Would you like to place your #{ship} [h]Horizontally or [v]Vertically? "
				reply_direction = gets.chomp
				print "What Row would you like to place your #{ship} ship? " 
				reply_row = gets.chomp
				print "What Column would you like to place your #{ship} ship? " 
				reply_column = gets.chomp
				if reply_direction.strip.downcase == "horizontally" || reply_direction.strip.downcase == "h"
					rows = []
					columns = []
					count = 0
					units.times do 
						rows << reply_row.upcase
						columns << (reply_column.to_i + count).to_s
						count += 1
					end
					rows
					columns
					cells = rows.zip(columns)
					p cells
					# p ship_keys[units[-1]]
					if @player_board.place((Ship.new(ship_keys[units[-1]])), cells) != "Invalid Coordinates"
						@player_board.place((Ship.new(ship_keys[units[-1]])), cells)
						system('cls')
						show_player_board
						break
					end
					# show_player_board
				else reply_direction.strip.downcase == "vertically" || reply_direction.strip.downcase == "v"
					rows = []
					columns = []
					count = 0
					units.times do
						# p Board::ROW.index(reply_row.upcase)
						rows << Board::ROW[(Board::ROW.index(reply_row.upcase) + count)]
						columns << reply_column
						count += 1
					end
					rows
					columns
					cells = rows.zip(columns)
					p cells
					if @player_board.place((Ship.new(ship_keys[units[-1]])), cells) != "Invalid Coordinates"
						# system('cls')
						@player_board.place((Ship.new(ship_keys[units[-1]])), cells)
						system('cls')
						show_player_board
						break
					end
					# system('cls')
					# show_player_board
					# show_player_board
					# break
				end
			end
		end
		# show_player_board
	end

			
	


end

game = Game.new()
game.set_player
game.set_difficulty
game.set_player_board
# game.show_player_board
game.set_opponent
game.setup_player

