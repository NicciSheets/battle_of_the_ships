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
	def initialize(row, column)
		@row = row
		@column = column
		@coordinates = "#{row}#{column}"
		@status = STATUS[:empty]
	end

	attr_reader :coordinates, :status, :row, :column

# changes the status of the cell to :hit if there is a hit
	def hit
		@status = STATUS[:hit] 
	end

# changes status of the cell to :miss if there was a miss attempt
	def miss
		@status = STATUS[:miss]
	end

# allows you to place a certain ship in the cell and makes that ship object pointer the status
	def place_ship(ship)
		@status = ship
	end

# does not show the ships status symbol, but instead "hides" it under the empty status "." - if there is a hit or a miss, it shows it, however
	def render_without_ships
		if @status == "."
			"."
		elsif @status == "X"
			"X"
		elsif @status == "0"
			"0"
		else
			"."
		end
	end

# shows all cell status's as they are
	def render_with_ships
		if @status == "."
			"."
		elsif @status == "X"
			"X"
		elsif @status == "0"
			"0"
		else
			STATUS[@status.type]
		end
	end

# returns the coordinates of row and column for each cell as one string
	def to_s
		"#{@coordinates}"
	end
end


# cruiser = Ship.new(:cruiser)
# cell = Cell.new("B", "4")
# cell.place_ship(cruiser)
# p cell.to_s
# p cell.row
# p cell.render_with_ships
# p cell.render_without_ships
# p cell.status
# p cell.hit
