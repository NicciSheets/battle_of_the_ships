require_relative "ship_class.rb"

class Cell

	STATUS = {
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
	end

	attr_reader :coordinates, :status

# returns the status of the cell with symbol in string from above STATUS hash, the second STATUE[@status.type] is used when there is a Ship object pointer as the status
	def render_status
		STATUS[@status] || STATUS[@status.type]
	end

# changes the status of the cell to :hit if there is a hit
	def hit
		# self.status.damage += 1
		@status = :hit 
	end

# changes status of the cell to :miss if there was a miss attempt
	def miss
		@status = :miss
	end

# allows you to place a certain ship in the cell and makes that ship object pointer the status
	def place_ship(type)
		# Ship.new(type)
		@status = type
	end

end


# cruiser = Ship.new(:cruiser)
# cell_1 = Cell.new("B4")
# p cruiser
# p cell_1
# p cell_1.render_status
# p cell_1.place_ship(cruiser)
# p cell_1
# p cell_1.render_status
# p cell_1.status.damage
# p cell_1.status.type
# p cruiser.hit
# p cell_1.hit
# p cell_1
# p cell_1.render_status
# p cruiser
# p cruiser.hit
# p cruiser.sunk?
