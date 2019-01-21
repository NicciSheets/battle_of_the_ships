require_relative "cell_class.rb"
require_relative "ship_class.rb"

class Board

	GRID_SIZE = {
		:beginner     => 12,
		:intermediate => 24, 
		:advanced     => 36
	}

# grid rows
	ROW = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'BB', 'CC', 'DD', 'EE', 'FF', 'GG', 'HH', 'II', 'JJ']

# grid columns
	COLUMN = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36']


# initializes the Board class with grid size attribute(how many cells in each row/column) and based on the difficulty attribute chosen
	def initialize(difficulty)
		@difficulty = difficulty
		@grid_size = GRID_SIZE[@difficulty]
		@grid_row = ROW.take(@grid_size)
		@grid_column = COLUMN.take(@grid_size)	
		grid = []
		coordinates = []
		grid_row = self.grid_row
    	grid_column = self.grid_column
    	grid_row.each do |letter|
	  		grid_column.each do |number|
	 			coordinates << "#{letter}#{number}"
	 		end
	 	end
	 	@coordinates = coordinates
		grid_row.each do |letter|
	  		grid_column.each do |number|
	 			grid << Cell.new(row = "#{letter}", column = "#{number}")
	 		end
	 	end
	 	@grid = grid.each_slice(self.grid_size).to_a
	end

	attr_reader :difficulty, :grid_size, :grid_row, :grid_column, :grid, :coordinates


# is first array of multidimensional row array - row[row_index(coordinates)][column_index(coordinates)]
	def row_index(row, column)
		ROW.index(row)
	end
# second array of multidimensional row array - row[row_index(coordnates)][column_index(coordinates)]
	def column_index(row, column)
		COLUMN.index(column)
	end
# pulls out individual cell class information with cooresponding board coordinates
	def cell_coordinates(row, column)
		row = row_index(row, column)
		column = column_index(row, column)
		self.grid[row][column]
	end
# need to use this no_sho_ships with cloned opponent's grid and make changes to the regular grid, then translate it to the render_without_ships grid for console; renders the grid without showing where the ships are placed, used for opponent's board
	def no_show_ships
		grid = []
		self.grid.each do |row|
			row.each do |cell|
				grid << cell.render_without_ships
			end
		end
		grid.each_slice(self.grid_size).to_a
	end
# opponent's board console ready
	def pretty_no_show
		self.no_show_ships.each do |row|
			p row
		end
	end
# renders grid, showing where the ships are for user's board
	def show_ships
		grid = []
		self.grid.each do |row|
			row.each do |cell|
				grid << cell.render_with_ships
			end
		end
		grid.each_slice(self.grid_size).to_a
	end
# user's board console ready
	def pretty_show
		self.show_ships.each do |row|
			p row
		end
	end
# gives the row value for each cell
	def row_arr(cells)
		row_arr = []
		cells.each do |row|
			row_arr << row[0]
		end
		row_arr
	end
# gives the column value for each cell
	def column_arr(cells)
		column_arr = []
		cells.each do |column|
			column_arr << column[1]
		end
		column_arr
	end
# checks to see if the cells are consecutive in a row, if so returns true
	def valid_placement_row?(ship, cells)
		row_arr = row_arr(cells)
		column_arr = column_arr(cells)
		((column_arr.last.to_i - column_arr.first.to_i) == (column_arr.count - 1)) && (row_arr.uniq.count == 1)
	end

# checks if cells are in same row down a column, if so returns true
	def valid_placement_column?(ship, cells)
		row_arr = row_arr(cells)
		column_arr = column_arr(cells)	
		((ROW.index(row_arr.last) - ROW.index(row_arr.first)) == (row_arr.count - 1)) && (column_arr.uniq.count == 1)		
	end		
# ship.length must be same as the number of cells given for ship to be placed in - returns true if so, false if not
	def valid_placement_length?(ship, cells)
		ship
		ship.length == cells.length
	end
# doesn't let you place a ship where there's already another ship, all cells coordinates must have status of empty, if all empty, returns true.
	def valid_placement_empty?(ship, cells)
		ship
		status_arr = []
		cells.each do |row, column|
			status_arr << self.cell_coordinates(row, column).status
		end
		status_arr.uniq.count == 1
	end
# returns true if all criteria are true for the cells and ship desired
	def valid_placement?(ship, cells)
		(valid_placement_empty?(ship, cells) && valid_placement_length?(ship, cells)) && (valid_placement_row?(ship, cells) || valid_placement_column?(ship, cells))
	end
# places a ship into the desired cells if it is true for valid_placement?
	def place(ship, cells)
		# @ship = ship
		if valid_placement?(ship, cells) == false
			"Invalid Placement, Try Again"
		else
			cells.each do |row, column|
				self.cell_coordinates(row, column).place_ship(ship)
			end
		end
	end

end


board = Board.new(:beginner)
p board
cruiser = Ship.new(:cruiser)
battleship = Ship.new(:battleship)
# submarine = Ship.new(:submarine)
# p board.row_index("B", "1")
# p board.row_index("AA", "1")
# p board.row_index("BB", "12")
# p board.column_index("A", "2")
# p board.column_index("AA", "2")
# p board.column_index("AA", "12")
 # p board.cell_coordinates("A", "1")
 # p board.cell_coordinates("A", "1").coordinates
 # p board.cell_coordinates("A", "1").status
 # p board.cell_coordinates("A", "1").place_ship(Ship.new(:cruiser))
 # p board.cell_coordinates("A", "2").place_ship(Ship.new(:cruiser))
 # p board.no_show_ships
 # board.pretty_no_show
# p board.show_ships
 # board.pretty_show
#  p board.cell_coordinates("A1")
#  p board.cell_coordinates("A1").hit
#  p cruiser.hit
#  p board.cell_coordinates("A2").hit
#  p cruiser.hit
#  p cruiser
#  p cruiser.sunk?
# p board.valid_placement_row?(cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# p board.valid_placement_row?(cruiser, [["A", "1"], ["A", "2"], ["A", "5"]])
# p board.valid_placement_column?(cruiser, [["A", "1"], ["B", "1"], ["C", "1"]])
# p board.valid_placement_column?(cruiser, [["A", "1"], ["B", "1"], ["C", "5"]])
# p board.valid_placement_length?(cruiser, [["A", "1"], ["B", "1"], ["C", "1"]])
# p board.valid_placement_length?(cruiser, [["A", "1"], ["B", "1"]])
# p board.valid_placement_empty?(battleship, [["A", "1"], ["B", "1"]])
# p board.valid_placement_empty?(battleship, [["B", "1"], ["C", "1"]])

# p board.show_ships
# board.pretty_show
# p board.valid_placement?(cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# p board.valid_placement?(cruiser, [["A", "1"], ["B", "1"], ["C", "1"]])
# p board.valid_placement?(cruiser, [["A", "1"], ["B", "2"], ["C", "3"]])
p board.place(cruiser, [["A", "1"], ["A", "2"], ["A", "3"]])
# # p board.show_ships
# board.pretty_show

# p board.place(battleship, [["A", "1"], ["B", "1"]])
# board.pretty_show
p board.place(battleship, [["B", "1"], ["B", "2"]])
# p board.place(battleship, ["B2", "B5"])
# p board.valid_placement?(battleship, ["B2", "D2"])
# p board.place(battleship, ["B2", "D2"])
# p board.valid_placement?(battleship, ["AA1", "AA2"])
# p board.place(battleship, ["AA1", "AA2"])
# p board.place(battleship, ["B12", "C1"])
# board.pretty_show
board.pretty_no_show
p board.cell_coordinates("A", "1")
p board.cell_coordinates("B", "1")
# p board.place(submarine, ["AA1", "BB1", "CC1", "DD1"])
# p board.place(submarine, ["BB1", "CC1", "DD1", "EE1"])
# p board.no_show_ships
# board.pretty_no_show
# p board.cell_coordinates("A1").
# board.pretty_no_show

# p board.cell_coordinates("A1").hit
# p cruiser.hit
# p board.show_ships
# board.pretty_show
# p cruiser
# p board.cell_coordinates("A1")
# p board.cell_coordinates("A2")
# p board.cell_coordinates("A1").status == board.cell_coordinates("A2").status


# !!!!!!!!!!!!my render without showing ships is not working properly!!