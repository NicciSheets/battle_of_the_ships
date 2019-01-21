require "minitest/autorun"
require_relative "board_class.rb"
require_relative "ship_class.rb"

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

	def test_if_valid_placement_true_can_place_ships_in_cells
		board = Board.new(:beginner)
		cruiser = Ship.new(:cruiser)
		cells = ["A1", "A2", "A3"]
		assert_equal(true, board.valid_placement?(cruiser, cells))
		ship_on_board = board.place(cruiser, cells)
		assert_equal(["A1", "A2", "A3"], ship_on_board)
		assert_equal("C", board.cell_coordinates("A1").status)
		assert_equal("C", board.cell_coordinates("A2").status)
		assert_equal("C", board.cell_coordinates("A3").status)
		assert_equal(".", board.cell_coordinates("A4").status)
		cells2 = ["B1", "B2"]
		assert_equal(false, board.valid_placement?(cruiser, cells2))
		ship_on_board2 = board.place(cruiser, cells2)
		assert_equal("Invalid Placement", ship_on_board2)
		assert_equal(".", board.cell_coordinates("B1").status)
	end

end