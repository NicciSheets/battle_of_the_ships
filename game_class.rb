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
		# type
		coordinates = self.opponent.board.coordinates.sample
		beginning_coord = coordinates2array(coordinates)
		rows = []
		columns = []
		ship_length = Ship::SHIP_INFO[type]
		p "ship_length is #{ship_length} and class is #{ship_length.class}"
		count = 0
		ship_length.times do
			rows << beginning_coord[0]
			columns << (beginning_coord[1].to_i + count)
			count += 1
		end
		rows
		columns
		rows.zip(columns)
	end


	def deploy_opponent_ships
		# orientation = [:horizontal, :vertical].sample
		# coordinates = self.opponent.board.coordinates.sample
		# beginning_coord = coordinates2array(coordinates)
		# p "beginning_coord is #{beginning_coord}"
		# p "orientation is #{orientation} and coordinates is #{coordinates}"
		# rows = []
		# columns = []
		# cell_coordinates= []
		# cells = []
		# beginning_row = beginning_coord[0]
		# beginning_column = beginning_coord[1]
		# p "beginning_column is #{beginning_column}"
		# Ship::SHIP_INFO.keys.each do |ship|
		# 	ship_length = Ship::SHIP_INFO[ship]
		# 	# while valid == false
		# 	# orientation = [:horizontal, :vertical].sample
		# 	if orientation == :horizontal
		# 		cell_number = ship_length-1
		# 		p "cell_number is #{cell_number}"
		# 		cell_number.times do 
		# 			rows << beginning_row
		# 			columns << (beginning_column.to_i)+1
		# 			cell_coordinates << rows << columns
		# 			cells << beginning_coord << cell_coordinates
		# 		end
		# 		cells
		# 						p "cells is #{cells}"

		# 	end
		# end
	end

			 # else
			# 	rows = Board::ROW[0..9 - ship.length]
			# 	columns = Board::COLUMN
			# end
		# end
	# end



end

p game = Game.new()
game.set_difficulty
game.set_player
game.create_opponent
game.player.pretty_show
game.opponent.pretty_no_show
p game.opponent.board.grid_size
# game.player.board.place(game.player.cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# game.player.board.place(game.player.battleship, [["B", "1"], ["C", "1"]])
# game.opponent.board.place(game.opponent.cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# game.player.pretty_show
# game.opponent.pretty_no_show
# p game.player.board.cell_coordinates("A", "1").status
# p game.opponent.board.cell_coordinates("A", "1").status
# p game.deploy_opponent_ships
p game.opponent_horizontal_cells(:submarine)