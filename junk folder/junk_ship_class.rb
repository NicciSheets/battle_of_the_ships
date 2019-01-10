# require_relative "board_class.rb"

class Ship

	SHIP_NAME = {
		2 => "battleship",
		3 => "cruiser",
		4 => "submarine",
		5 => "destroyer"
	}

	attr_reader :length, :damage

	attr_accessor :starting_coordinate
# initializes with length of the ship (either 2, 3 or 4) and starts out with 0 damage
	def initialize(length, starting_coordinate)
		@length = length
		@damage = 0
		@ship_name = SHIP_NAME[length]
		# starting_coordinate = self.starting_coordinate(coordinate)
		@starting_coordinate = starting_coordinate
		# p self
	end

	# def starting_coordinate(coordinate)
	# 	Board.holds_ship(coordinate)
	# end

# if the ship gets hit by opponent, @damage is increased by 1
	def hit
		@damage +=1
	end


# if the ship's damage is equal to its length, then the ship is considered sunk? and returns true for this method
	def sunk?
		@length == @damage
	end

end

x = Ship.new(2, "A2")
# p x.ship_array
# p x.starting_coordinate
# p "x is #{x}"
# p "x.starting_coordinate is #{x.starting_coordinate}"
# p "starting_coordinate is #{Ship.new(2, "A2").starting_coordinate}"