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
		p "board1 is #{board1.grid}"
	end
end