require "minitest/autorun"
require_relative "board_class.rb"

class TddBoardClass < Minitest::Test

	def test_board_is_class
		board1 = Board.new("beginner")
		assert_equal(Board, board1.class)
		assert_equal("beginner", board1.difficulty)
	end

	def test_correct_grid_size_returns
		board1 = Board.new("beginner")
		assert_equal(12, board1.grid_size?)
		board2 = Board.new("intermediate")
		assert_equal(24, board2.grid_size?)
		board3 = Board.new("advanced")
		assert_equal(36, board3.grid_size?)
	end

	def test_grid
		board1 = Board.new("beginner")
		beg_grid = board1.grid
		# this is an array of 12 arrays that have 12 indexes in each array
		assert_equal(12, beg_grid.length)
		# this shows that there's individual arrays that hold 12 items each within the larger "grid" array
		assert_equal(12, beg_grid[0].length)
		assert_equal(12, beg_grid[11].length)
	end


end