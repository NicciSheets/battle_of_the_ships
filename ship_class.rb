require_relative "board_class.rb"

class Ship

	attr_reader :length, :damage

# initializes with length of the ship (either 2, 3 or 4) and starts out with 0 damage
	def initialize(length)
		@length = length
		@damage = 0
	end


# if the ship gets hit by opponent, @damage is increased by 1
	def hit
		@damage +=1
	end


# if the ship's damage is equal to its length, then the ship is considered sunk? and returns true for this method
	def sunk?
		@length == @damage
	end

end
