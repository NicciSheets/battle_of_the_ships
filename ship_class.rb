class Ship

	SHIP_INFO = {
		:battleship => 2,
		:cruiser    => 3,
		:submarine  => 4,
		:destroyer  => 5
	}

# initializes with the type(name) of ship, length(how many cells it takes up) and starts out with 0 damage 
	def initialize(type)
		@type = type
		@length = SHIP_INFO[type]
		@damage = 0
	end

	attr_reader :type, :length

	attr_accessor :damage

# with each correct hit, adds +1 damage to the ship
	def hit
		@damage +=1
	end

# boolean for whether or not the ship has been sunk(when ship's damage == ship's length)
	def sunk?
		@damage == @length
	end
	
	# # custom return for ship class
# 	def to_s
# 		"#{@type}"
# 	end
end
