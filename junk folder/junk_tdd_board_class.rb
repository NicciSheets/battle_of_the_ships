require "minitest/autorun"
require_relative "board_class.rb"

class TddBoardClass < Minitest::Test

	def test_board_is_class
		board1 = Board.new("beginner")
		assert_equal(Board, board1.class)
		assert_equal("beginner", board1.difficulty)
		assert_equal(12, board1.grid_size)
	end

	def test_x_grid
		board1 = Board.new("beginner")
		grid = board1.x_grid
		assert_equal(Array, grid.class)
		assert_equal(12, grid.length)
		assert_equal(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"], grid)
		board2 = Board.new("intermediate")
		grid2 = board2.x_grid
		assert_equal(Array, grid2.class)
		assert_equal(24, grid2.length)
		assert_equal(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X"], grid2)
		board3 = Board.new("advanced")
		grid3 = board3.x_grid
		assert_equal(Array, grid3.class)
		assert_equal(36, grid3.length)
		assert_equal(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"], grid3)
	end

	def test_y_grid
		board1 = Board.new("beginner")
		grid = board1.y_grid
		assert_equal(Array, grid.class)
		assert_equal(12, grid.length)
		assert_equal(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], grid)
		board2 = Board.new("intermediate")
		grid2 = board2.y_grid
		assert_equal(Array, grid2.class)
		assert_equal(24, grid2.length)
		assert_equal(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"], grid2)
		board3 = Board.new("advanced")
		grid3 = board3.y_grid
		assert_equal(Array, grid3.class)
		assert_equal(36, grid3.length)
		assert_equal(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36"], grid3)
	end

	def test_grid
		board1 = Board.new("beginner")
		grid = board1.grid
		assert_equal(Array, grid.class)
		assert_equal(12, grid.length)
		assert_equal(12, grid[11].length)
		assert_equal(true, grid[0].include?("A1"))
		assert_equal(true, grid[0].include?("A12"))
		assert_equal(true, grid[11].include?("L1"))
		assert_equal(true, grid[11].include?("L12"))
		board2 = Board.new("intermediate")
		grid2 = board2.grid
		assert_equal(Array, grid2.class)
		assert_equal(24, grid2.length)
		assert_equal(24, grid2[5].length)
		assert_equal(true, grid2[0].include?("A1"))
		assert_equal(true, grid2[0].include?("A24"))
		assert_equal(true, grid2[23].include?("X1"))
		assert_equal(true, grid2[23].include?("X24"))
		board3 = Board.new("advanced")
		grid3 = board3.grid
		assert_equal(Array, grid3.class)
		assert_equal(36, grid3.length)
		assert_equal(36, grid3[0].length)
		assert_equal(true, grid3[0].include?("A1"))
		assert_equal(true, grid3[0].include?("A36"))
		assert_equal(true, grid3[35].include?("j1"))
		assert_equal(true, grid3[35].include?("j36"))
	end

	def test_x_axis_ship_start
		ship1 = Ship.new(2, "A4")
		board1 = Board.new("beginner")
		p "board1.x_grid2grid is #{board1.x_grid2grid}"
	end
end