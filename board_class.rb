class Board

	DIFF_LEVEL_SIZE = {
			"beginner"     => 12, 
			"intermediate" => 24, 
			"advanced"     => 36
		}

	attr_reader :difficulty


# initializes Board class with the difficulty that user will eventually be able to choose (will be one of the keys from the constant DIFF_LEVEL)
	def initialize(difficulty)
		@difficulty = difficulty	
	end


# this gives you the grid size that is associated with the diff level that is chosen
	def grid_size?
		DIFF_LEVEL_SIZE[difficulty]
	end

end