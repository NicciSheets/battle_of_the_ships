require "minitest/autorun"
require_relative "board_class.rb"

class TddBoardClass < Minitest::Test

	def test_board_is_class_and_returns_difficulty_attribute_and_gridsize_attribute
		beg_board = Board.new(:beginner)
		# p beg_board
		int_board = Board.new(:intermediate)
		# p int_board
		adv_board = Board.new(:advanced)
		# p adv_board
	end





	def test_valid_placement_for_cells_on_board
		board = Board.new(:beginner)
		cruiser = Ship.new(:cruiser)
		cells = ["A1", "A2", "A3"]
		cells2 = ["A1", "C2"]
		assert_equal(true, board.valid_placement?(cruiser, cells))
		assert_equal(false, board.valid_placement?(cruiser, cells2))
		cells3 = ["A1", "A2", "B3"]
		assert_equal(false, board.valid_placement?(cruiser, cells3))
		cells4 = ["A1", "B1", "C1"]
		assert_equal(true, board.valid_placement?(cruiser, cells4))
		cells5 = ["A1", "B2", "C3"]
		assert_equal(false, board.valid_placement?(cruiser, cells5))
		cells6 = ["A1", "A2"]
		assert_equal(false, board.valid_placement?(cruiser, cells6))
	end

end