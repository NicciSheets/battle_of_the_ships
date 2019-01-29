# require_relative "ship_class.rb"
# require_relative "cell_class.rb"
require_relative "board_class.rb"

class Player


	def initialize(player, difficulty)
		@player = player
		@board = Board.new(difficulty)
		@battleship = Ship.new(:battleship)
		@cruiser = Ship.new(:cruiser)
		@submarine = Ship.new(:submarine)
		@destroyer = Ship.new(:destroyer)
		@coordinates_to_play = Board.new(difficulty).coordinates
		@ships_left = Board::SHIPS_LEFT
	end

	attr_reader :player, :board, :battleship, :cruiser, :submarine, :destroyer, :coordinates_to_play

	attr_accessor :ships_left

	def show_player_board
		board_layout = @board.show_ships
		row_label = @board.grid_column
		column_label = @board.grid_row
		puts
		print "#{@player}'s Board: #{@ships_left} Ships Remaining"
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

	def show_opponent_board
		# board_layout = @board.no_show_ships
		board_layout = @board.show_ships
		row_label = @board.grid_column
		column_label = @board.grid_row
		puts
		print "#{@player} Board: #{@ships_left} Ships Remaining"
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

 	def to_s
 		@player.capitalize
 	end

 	# def ships_left1
 	# 	@ships_left -= 1
 	# end
end

# nicci = Player.new("nicci", :beginner)
# p nicci.ships_left1
# nicci.pretty_show
# nicci.pretty_no_show
# nicci.board.place(nicci.cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# nicci.pretty_show
# nicci.pretty_no_show
# p nicci.to_s