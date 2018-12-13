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
	end


# this makes the x-axis letters for the grid (capital letters A-Z first, followed by a-z, if necessary)
# will be useful for the grid labels
	def x_grid
		grid_letter = {12 => 76.chr, 24 => 88.chr, 36 => 106.chr}
		letter99 = grid_letter[grid_size]
		letters = []   
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

    def grid()
    	x_axis = self.x_grid
    	y_axis = self.y_grid
    	board99 = Hash.new
    	x_axis.each do |letter|
    		y_axis.each do |number|
    			board99["#{letter}#{number}"] = "*"
    		end
    	end
    	board99
    end

# this lays out the grid according to the size for each difficulty level, as an array of arrays
# useful for seeing what grid looks like in terminal
 #    def grid
	# 	grid_letter = {12 => 76.chr, 24 => 88.chr, 36 => 106.chr}
	# 	letter99 = grid_letter[grid_size]
	# 	board99 = Hash.new
	# 	(65.chr..letter99).each do |letter|
	# 		(1..self.grid_size).each do |i|
	# 			board99["#{letter.to_s.gsub(/[^A-Za-z]/, "")}#{i}"] = "*"
	# 		end
	# 	end
	# 	board99
	# end


end

# board1 = Board.new("beginner")
# p board1.grid.index("A12")






		