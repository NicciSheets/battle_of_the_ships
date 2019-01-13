require "minitest/autorun"
require_relative "board_class.rb"

class TddBoardClass < Minitest::Test

	def test_board_is_class_and_returns_difficulty_attribute_and_gridsize_attribute
		beg_board = Board.new(:beginner)
		p beg_board
		int_board = Board.new(:intermediate)
		p int_board
		adv_board = Board.new(:advanced)
		p adv_board
	end

end