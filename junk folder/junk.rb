# this is in my junk folder because for right now, I'm only using the self.grid and self.pretty_grid for its coordinate information so I can transpose the correct multidimensional hash index for each coordinate (coordinate will be what the game uses for each space, but will still need to be "translated" into the multidimensional array index)

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
# can possibly still use the letters for the grid labeling, just use the index of the letter being called, so A2 = [0][1]
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


# this makes a multidimensional array using the x_grid and y_grid for each of the coordinates held within the grid for each difficulty level
    def grid
    	board99 = []
    	self.x_grid.each do |letter|
    		self.y_grid.each do |number|
    			board99 << "#{letter}#{number}"
    		end
    	end
    	pretty_board = []
    	board99.each_slice(self.grid_size) {|space| (pretty_board << space)}
    	pretty_board
    end


# this makes it so much easier to see on the board, each row is broken down into separate arrays for console
    def pretty_grid
    	self.grid.each do |row|
    		p row
    	end
    end

end

board = Board.new("beginner")
# p board.grid
board.pretty_grid