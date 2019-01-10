require_relative "ship_class.rb"


class Board

	GRID_SIZE = {
			"beginner"     => 12, 
			"intermediate" => 24, 
			"advanced"     => 36
		}



	attr_reader :difficulty, :grid_size



# initializes Board class with the difficulty that user will eventually be able to choose, as well as its corresponding length for the grid size
	def initialize(difficulty)
		@difficulty = difficulty
		@grid_size = GRID_SIZE[difficulty]
		# @start_ship = Board.start_ship
		# @ship = SHIP_ARRAY[Ship.ship_name]
	end

	def self.ship
		start = ""
		ship_array = ["battleship", "cruiser", "submarine", "destroyer"]
		a = Ship.starting_coordinate
		"a starting coord is #{a}"
		# ship_array.each do 
			# start << Ship.starting_coordinate
		# end
		# start
		# SHIP_ARRAY(Ship)
	end

# this makes the x-axis letters for the grid (capital letters A-Z first, followed by a-z, if necessary)
# can possibly still use the letters for the grid labeling, just use the index of the letter being called, so A2 = [0][1]
	def x_grid
		grid_letter = {12 => 76.chr, 24 => 88.chr, 36 => 106.chr}
		# p "grid_size is #{self.grid_size}"
		letter99 = grid_letter[self.grid_size]
		letters = []   
		# p "letter99 is #{letter99}"
        (65.chr..letter99).each do |letter|
        	letter99 = letter.to_s.gsub(/[^A-Za-z]/, "")
        	if letter99 == "" 
        		letter99 = nil
        	else 
        		letter99
        	end
        	letters << letter99
        end
        # p letters
        letters.compact
    end


# this makes the y-axis numbers for the grid, mostly used for labeling the grid, but also to make the space coordinates held within
    def y_grid
    	numbers = []
    	(1..self.grid_size).each do |i|
    		numbers << i.to_s
    	end
    	numbers
    end


# # this makes a multidimensional array using the x_grid and y_grid for each of the coordinates held within the grid for each difficulty level
#     def grid
#     	board99 = []
#     	self.x_grid.each do |letter|
#     		self.y_grid.each do |number|
#     			board99 << "#{letter}#{number}"
#     		end
#     	end
#     	pretty_board = []
#     	board99.each_slice(self.grid_size) {|space| (pretty_board << space)}
#     	pretty_board
#     end


# # this makes it so much easier to see on the board, each row is broken down into separate arrays for console
#     def pretty_grid
#     	self.grid.each do |row|
#     		p row
#     	end
#     end


# console gameboard = this is just to show what the grid looks like at start, before ships are placed and game begins
	def grid2
		blank_row = Array.new(self.grid_size, false)
		board = Array.new(self.grid_size) { blank_row.clone }
	# commented out lines below are for ship placement
		# board[0][1] = true
		# p "board[0][1] is A2 & to get the first number 1 / 10 #{1/10}"
		# p "to get the second number 1 % 10 #{1%10}"
		board.each.with_index do |row, y|
	  		row.each.with_index do |v, x|
	    # change a true cell to 'S' and false to '.'
				if v
	 				board[y][x] = 'S'
				else
	  				board[y][x] = '.'
	  			end
	  		end
		end
	end


# console gameboard = this goes with the above method, showing the grid before ship placement and prior to game start
	def pretty_grid2
    	self.grid2.each do |row|
    		p row
    	end
    end


# this is for game play, when coordinate is called, ex. "A2", then the cooresponding spot on the console gameboard is changed to an S, meaning it is now occupied by Ship
	def grid2_ship(ship_coordinate)
		blank_row = Array.new(self.grid_size, false)
		board = Array.new(self.grid_size) { blank_row.clone }
		x_axis = x_grid2grid(ship_coordinate)
    	y_axis = y_grid2grid(ship_coordinate)
    	board[y_axis][x_axis] = true
		board.each.with_index do |row, y|
	  		row.each.with_index do |v, x|
	    # change a true cell to 'S' and false to '.'
				if v
	 				board[y][x] = 'S'
				else
	  				board[y][x] = '.'
	  			end
	  		end
	  	end
	end

	def self.holds_ship(ship_coordinate)
		# blank_row = Array.new(self.grid_size, false)
		# board = Array.new(self.grid_size) { blank_row.clone }
		x_axis = x_grid2grid(ship_coordinate)
		y_axis = y_grid2grid(ship_coordinate)
		board[y_axis][x_axis] 
	end

# # !!!!!!!!!!!!!!!!! can't get this to work correctly 
# # this is for game play, to show the ships placed in a neat manner on console
# 	def pretty_grid_ship
# 		# x = self.
# 		x = @ship_grid
# 		p x
# 		# .each do |row|
# 			# p row
# 		# end
# 	end


# this translates the x_axis from grid method ("A2" = "A") to a numeric value to be used to find cooresponding index on grid2
    def y_grid2grid(ship_coordinate)
    	# self.grid
    	p "ship_coordinate[0] is #{ship_coordinate[0]}"
    	y = ship_coordinate[0].to_i 
    	# p "x2 is #{x2} and x is #{x}"
    end


# this translates the y-axis from grid method ("A2" = "2") to a numeric value to be used to find cooresponding index on grid2
    def x_grid2grid
    	coordinate = Card.starting_coordinate
    	# p "coordinate is #{coordinate}"
    	# self.grid2
    	# p "ship_coordinate[1] is #{ship_coordinate[1]}"
    	# start_ship = Ship.starting_coordinate
    	# p "start ship is #{start_ship}"
    	# p self.starting_coordinate
    	# p "@start_ship is #{@start_ship}"
    	x2 = coordinate[1]
    	# p "x2 is #{x2}"
    	x = self.x_grid.index(x2).to_i - 1
    	# p "y is #{y}"
    end
   
   	# def start_ship()
   	# 	x = self.ship.starting_coordinate
   	# 	p "x is #{x}"
   	# 	# p "start is #{start}"
   	# end

   	# def ships_2b_placed
   	# 	ship_array = []
   	# 	ship_array << Ship::SHIP_NAME.keys
   	# end
    
end


# board1 = Board.new("beginner") 
# p board1.grid2_ship("D3")
# p "board1.grid2_ship('D3') is #{board1.grid2_ship('D3')}"
# board99.pretty_grid_ship
# p "board99 is #{board99}"
# p board1.x_grid2grid
# p "board1.y_grid2grid('D3') is #{board1.y_grid2grid('D3')}"
# p board1.grid2
# p board1.ships_2b_placed
# 









		