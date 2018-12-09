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


# this lays out the grid according to the size for each difficulty level, as an array of arrays
# useful for seeing what grid looks like in terminal
	def grid
		val = nil
		x = Array.new(self.grid_size) { Array.new(self.grid_size) { val } }	
		x.each do |row|
			p row
		end
	end

end

# board1 = Board.new("intermediate")
# board1.grid
# p board1
