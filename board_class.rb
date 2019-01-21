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
		grid = Array.new
		row = self.grid_row
    	column = self.grid_column
		row.each do |letter|
	  		column.each do |number|
	 			grid << Cell.new(coordinates = "#{letter+number}")
	 		end
	 	end
	 	@grid = grid.each_slice(self.grid_size).to_a
	end

	attr_reader :difficulty, :grid_size, :grid_row, :grid_column, :grid


# is first array of multidimensional row array - row[row_index(coordinates)][column_index(coordinates)]
	def row_index(coordinates)
		double_letter = ""
		if coordinates.length != 2
			if coordinates[0] == coordinates[1]
				ROW.index(coordinates[0]+coordinates[1].to_s)
			else
				ROW.index(coordinates[0])
			end
		else 
			ROW.index(coordinates[0])
		end
	end
	
# second array of multidimensional row array - row[row_index(coordnates)][column_index(coordinates)]
	def column_index(coordinates)
		double_digit = ""
		if coordinates.length == 2
			COLUMN.index(coordinates[1])
		else
			if coordinates[0] != coordinates[1]
				COLUMN.index(coordinates[1]+coordinates[2].to_s)
			else
				if coordinates.length == 4
					COLUMN.index(coordinates[2]+coordinates[3].to_s)
				else
					COLUMN.index(coordinates[2])
				end
			end
		end
	end

	# 	if coordinates.length != 2
	# 		if coordinates[0] != coordinates[1]
	# 			if coordinates.length == 2
	# 				coordinates[1].to_i - 1
	# 			else
	# 				(coordinates[1].to_i+coordinates[2].to_i) - 1
	# 			end
	# 		else
	# 			if coordinates.length == 3
	# 				coordinates[2].to_i - 1
	# 			else
	# 				(coordinates[2].to_i+coordinates[3].to_i) - 1
	# 			end
	# 		end
	# 	end
	# end
		# column = (coordinates[1].to_i - 1)
	# end
# pulls out individual cell class information with cooresponding board coordinates
	def cell_coordinates(coordinates)
		row = row_index(coordinates)
		column = column_index(coordinates)
		self.grid[row][column]
	end
# renders the grid without showing where the ships are placed, used for opponent's board
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

# returns the index of corresponding letter in ROW array constant
	def row_arr(cells)
		row_arr = []
		row_arr2 = []
		cells.each do |row|
			row_arr << row
		end
		row_arr.each do |coordinates|
			row_arr2 << row_index(coordinates)
		end
		row_arr2
	end
# returns array of the integers in the column for each cell's coordinates
	def column_arr(cells)
		column_arr = []
		column_arr2 = []
		cells.each do |column|
			column_arr << column
		end
		column_arr.each do |coordinates|
			column_arr2 << column_index(coordinates)
		end
		column_arr2
	end
# checks to see if the cells are consecutive in a row, if so returns true
	def valid_placement_row?(ship, cells)
		ship
		row_arr = row_arr(cells)
		p "row_arr is #{row_arr}"
		column_arr = column_arr(cells)
		p "column_arr is #{column_arr}"
		((column_arr.last.to_i - column_arr.first.to_i) == (column_arr.count - 1)) && (row_arr.uniq.count == 1)
	end
# checks to see if cells are horizontally and consecutively in a column, if so returns true
	def valid_placement_column?(ship, cells)
		ship
		row_arr = row_arr(cells)
		column_arr = column_arr(cells)
		((row_arr.last - row_arr.first) == (row_arr.count - 1)) && (column_arr.uniq.count == 1)
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
		cells.each do |cells|
			status_arr << self.cell_coordinates(cells).status
		end
		status_arr.uniq.count == 1
	end

	def valid_placement?(ship, cells)
		(valid_placement_empty?(ship, cells) && valid_placement_length?(ship, cells)) && (valid_placement_row?(ship, cells) || valid_placement_column?(ship, cells))
	end

	def place(ship, cells)
		if valid_placement?(ship, cells) == false
			"Invalid Placement, Try Again"
		else
			cells.each do |coordinates|
				self.cell_coordinates(coordinates).place_ship(ship)
			end
		end
	end

end


p board = Board.new(:advanced)
p cruiser = Ship.new(:cruiser)
p battleship = Ship.new(:battleship)
# p board.row_index("B1")
# p board.row_index("AA1")
# p board.row_index("AA2")
# p board.row_index("C12")
# p board.row_index("BB12")
# p board.column_index("A2")
# p board.column_index("AA2")
# p board.column_index("A12")
# p board.column_index("AA12")
#  p board.cell_coordinates("A1")
 # p board.cell_coordinates("A11").coordinates
 # p board.cell_coordinates("A11").status
 # p board.cell_coordinates("A1").place_ship(Ship.new(:cruiser))
#  p board.cell_coordinates("A2").place_ship(Ship.new(:cruiser))
#  # p board.no_show_ships
#  # board.pretty_no_show
 # p board.show_ships
 # board.pretty_show
#  p board.cell_coordinates("A1")
#  p board.cell_coordinates("A1").hit
#  p cruiser.hit
#  p board.cell_coordinates("A2").hit
#  p cruiser.hit
#  p cruiser
#  p cruiser.sunk?
# # p board.no_show_ships
# # board.pretty_no_show
# p board.show_ships
# p board.grid[0][0]
# board.pretty_show
# p board.valid_placement?(cruiser, ["A1", "A2", "B3"])
# p board.show_ships
# board.pretty_show
# p board.valid_placement?(cruiser, ["A1", "A2", "A3"])
# p board.valid_placement?(cruiser, ["A1", "B1", "C1"])
# p board.valid_placement?(cruiser, ["A1", "B2", "C3"])
p board.place(cruiser, ["A1", "A2", "A3"])
# # p board.show_ships
# board.pretty_show
# p board.valid_placement_empty?(battleship, ["A1", "B1"])
# p board.valid_placement?(battleship, ["A1", "B1"])
# p board.place(battleship, ["A1", "B1"])
board.pretty_show
# p board.valid_placement?(battleship, ["B2", "B5"])
# p board.place(battleship, ["B2", "B5"])
# p board.valid_placement?(battleship, ["B2", "D2"])
# p board.place(battleship, ["B2", "D2"])
p board.valid_placement?(battleship, ["AA1", "AA2"])
p board.place(battleship, ["AA1", "AA2"])
# p board.place(battleship, ["B12", "C1"])
board.pretty_show
# p board.cell_coordinates("A1").hit
# p cruiser.hit
# p board.show_ships
# board.pretty_show
# p cruiser
# p board.cell_coordinates("A1")
# p board.cell_coordinates("A2")
# p board.cell_coordinates("A1").status == board.cell_coordinates("A2").status

