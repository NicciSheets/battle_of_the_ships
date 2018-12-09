class Board

	attr_reader :difficulty

DIFF_LEVEL = {
		"beginner"     => 12, 
		"intermediate" => 24, 
		"advanced"     => 36
	}


def initialize(difficulty)
	@difficulty = difficulty	
end

def grid_size?
	DIFF_LEVEL[difficulty]
end

end