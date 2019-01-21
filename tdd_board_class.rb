require "minitest/autorun"
require_relative "board_class.rb"
require_relative "ship_class.rb"

class TddBoardClass < Minitest::Test

	def test_board_is_class_and_returns_difficulty_attribute_and_gridsize_attribute
		beginner = Board.new(:beginner)
		assert_equal(Board, beginner.class)
		assert_equal(:beginner, beginner.difficulty)
		assert_equal(12, beginner.grid_row.count)
		assert_equal(12, beginner.grid_column.count)
		assert_equal(144, beginner.coordinates.count)
		assert_equal(".", beginner.grid[0][0].status)
		intermediate = Board.new(:intermediate)
		assert_equal(Board, intermediate.class)
		assert_equal(:intermediate, intermediate.difficulty)
		assert_equal(24, intermediate.grid_row.count)
		assert_equal(24, intermediate.grid_column.count)
		assert_equal(576, intermediate.coordinates.count)
		advanced = Board.new(:advanced)
		assert_equal(Board, advanced.class)
		assert_equal(:advanced, advanced.difficulty)
		assert_equal(36, advanced.grid_row.count)
		assert_equal(36, advanced.grid_column.count)
		assert_equal(1296, advanced.coordinates.count)
	end

	def test_row_index_returns_correctly_for_coordinates
		beginner = Board.new(:beginner)
		assert_equal(0, beginner.row_index("A", "1"))
		assert_equal(2, beginner.row_index("C", "4"))
	end




	def test_valid_placement_for_cells_on_board
		board = Board.new(:beginner)
		cruiser = Ship.new(:cruiser)
		cells = [["A", "1"], ["A", "2"], ["A", "3"]]
		cells2 = [["A", "1"], ["C", "2"]]
		assert_equal(true, board.valid_placement?(cruiser, cells))
		assert_equal(false, board.valid_placement?(cruiser, cells2))
		cells3 = [["A", "1"], ["A", "2"], ["B", "3"]]
		assert_equal(false, board.valid_placement?(cruiser, cells3))
		cells4 = [["A", "1"], ["B", "1"], ["C", "1"]]
		assert_equal(true, board.valid_placement?(cruiser, cells4))
		cells5 = [["A", "1"], ["B", "2"], ["C", "3"]]
		assert_equal(false, board.valid_placement?(cruiser, cells5))
		cells6 = [["A", "1"], ["A", "2"]]
		assert_equal(false, board.valid_placement?(cruiser, cells6))
	end

	def test_if_valid_placement_true_can_place_ships_in_cells
		board = Board.new(:beginner)
		cruiser = Ship.new(:cruiser)
		cells = [["A", "1"], ["A", "2"], ["A", "3"]]
		assert_equal(true, board.valid_placement?(cruiser, cells))
		ship_on_board = board.place(cruiser, cells)
		assert_equal(:cruiser, board.cell_coordinates("A", "1").status.type)
		assert_equal(:cruiser, board.cell_coordinates("A", "2").status.type)
		assert_equal(:cruiser, board.cell_coordinates("A", "3").status.type)
		assert_equal(".", board.cell_coordinates("A", "4").status)
		assert_equal(true, board.cell_coordinates("A", "1").status==board.cell_coordinates("A", "2").status)
		cells2 = [["B", "1"], ["B", "2"]]
		assert_equal(false, board.valid_placement?(cruiser, cells2))
		ship_on_board2 = board.place(cruiser, cells2)
		assert_equal("Invalid Placement, Try Again", ship_on_board2)
		assert_equal(".", board.cell_coordinates("B", "1").status)
	end

end