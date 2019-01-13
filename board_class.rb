require_relative "cell_class.rb"

class Board

	Grid_Size = {
		:beginner     => 12,
		:intermediate => 24, 
		:advanced     => 36
	}

# initializes the Board class with grid size attribute(how many cells in each row/column) and based on the difficulty attribute chosen
	def initialize(difficulty)
		@difficulty = difficulty
		@grid_size = Grid_Size[@difficulty]
	end

	attr_reader :difficulty, :grid_size

end