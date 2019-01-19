require_relative "cell_class.rb"

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
		ROW.index(coordinates[0])
	end
# second array of multidimensional row array - row[row_index(coordnates)][column_index(coordinates)]
	def column_index(coordinates)
		column = (coordinates[1].to_i - 1)
	end
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
	
end


p board = Board.new(:beginner)
 cruiser = Ship.new(:cruiser)

 p board.cell_coordinates("A1")
 p board.cell_coordinates("A1").coordinates
 p board.cell_coordinates("A1").status
 p board.cell_coordinates("A1").place_ship(cruiser)
 p board.cell_coordinates("A2").place_ship(cruiser)
 # p board.no_show_ships
 # board.pretty_no_show
 p board.show_ships
 board.pretty_show
 p board.cell_coordinates("A1")
 p board.cell_coordinates("A1").hit
 p cruiser.hit
 p cruiser
# p board.no_show_ships
# board.pretty_no_show
p board.show_ships
board.pretty_show
 