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
		@status = STATUS[ship.type]
	end

# does not show the ships status symbol, but instead "hides" it under the empty status "." - if there is a hit or a miss, it shows it, however
	def render_without_ships
		if @status == "B"
			@status = "."
		elsif @status == "C"
			@status = "."
		elsif @status == "S"
			@status = "."
		elsif @status == "D"
			@status = "."
		else
			@status
		end
	end

# shows all cell status's as they are
	def render_with_ships
		@status
	end
end


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
