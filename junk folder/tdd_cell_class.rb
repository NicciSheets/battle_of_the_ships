require "minitest/autorun"
require_relative "cell_class.rb"

class TddCellClass < Minitest::Test

	def test_cell_is_class
		cell = Cell.new("B4")
		assert_equal(Cell, cell.class)
		assert_equal("B4", cell.coordinates)
	end
end