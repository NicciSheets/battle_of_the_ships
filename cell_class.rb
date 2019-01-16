require_relative "ship_class.rb"

class Cell

	Status = {
		:empty      => ".", 
		:hit        => "X",
		:miss       => "0", 
		:battleship => "B",
		:cruiser    => "C",
		:submarine  => "S",
		:destroyer  => "D"
	}

# intiliazes Cell class with @coordinates for each individual cell and empty status(".")
	def initialize(coordinates)
		@coordinates = coordinates
		@status = :empty
		# @damage = Ship.new(type).damage
	end

	attr_reader :coordinates, :status

	attr_accessor :damage


	def cell_status
		Status[@status]
	end

# changes the status of the cell to "X" if there is a hit
	def hit
		# @damage = Ship.new(type).hit
		@status = :hit
	end

# changes status of the cell to "0" if there was a miss attempt
	def miss_ship
		@status = :miss
	end

# returns the string representation of what the cell's value is(what it's holding)
	def to_s
		Status[@status]
	end

# allows you to place a certain ship in the cell and alters the status of that cell to appropriate symbol(B, C, S, D)
	def place_ship(type)
		Ship.new(type)
		@status = type
	end

	# def ship
	# 	ship = self.place_ship(type)
	# 	Status[ship]

	
	# end
end
# ship - Ship.new(:battleship)
# cell = Cell.new("B4")
# p cell
# p cell.place_ship(:battleship)
# p cell
# p cell.hit
# p cell.ship
# p cell.damage
# p cell