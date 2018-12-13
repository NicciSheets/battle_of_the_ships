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


end