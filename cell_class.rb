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

# intiliazes Cell class with @coordinates for each individual cell
	def initialize(coordinates)
		@coordinates = coordinates
		@status = :empty
	end

	attr_reader :coordinates, :status

	def hit_ship
		@status = :hit
	end

	def miss_ship
		@status = :miss
	end

	def to_s
		Status[@status]
	end


end