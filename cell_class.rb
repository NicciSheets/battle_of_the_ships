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
		@status = STATUS[:empty]
	end

	attr_reader :coordinates, :status

# returns the status of the cell with symbol in string from above STATUS hash, the second STATUE[@status.type] is used when there is a Ship object pointer as the status
	# def render_status
	# 	# @type = @status
	# 	STATUS[@status]
	# end

# changes the status of the cell to :hit if there is a hit
	def hit
		# self.status.damage += 1
		@status = STATUS[:hit] 
	end

# changes status of the cell to :miss if there was a miss attempt
	def miss
		@status = STATUS[:miss]
	end

# allows you to place a certain ship in the cell and makes that ship object pointer the status
	def place_ship(ship)
		# Ship.new(type)
		@status = ship	
	end

	def render_without_ships
		STATUS[@status] = "."
	end

	def render_with_ships
		STATUS[@status] = STATUS[@status.type]
	end

	def to_s
		"#{STATUS.key(self.status)}"
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


# !!!!!Thinking of way to not show opponents ships on board by rendering the ship status symbols as ".", should still keep the ship object pointer in its place, though.
# cruiser = Ship.new(:cruiser)
# cell = Cell.new("B4")
# p cruiser 
# p cell
# cell.place_ship(cruiser)
# p cell
# p cell.render_with_ships
# p cell.render_without_ships
# p cell.status
# p cell.render_without_ships
# p cell.render_with_ships
# p cell.hit
# p cell
# p cell.to_s
