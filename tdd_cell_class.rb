require "minitest/autorun"
require_relative "cell_class.rb"

class TddCellClass < Minitest::Test

	def test_cell_is_class
		cell = Cell.new("B4")
		# p cell
		assert_equal(Cell, cell.class)
		assert_equal("B4", cell.coordinates)
		assert_equal(:empty, cell.status)
	end

	def test_status_is_hit_or_miss
		cell = Cell.new("B4")
		assert_equal(:hit, cell.hit_ship)
		assert_equal(:miss, cell.miss_ship)
	end

	def test_cell_class_returns_as_cell_status_with_to_s
		cell = Cell.new("B4")
		assert_equal("hit", cell.hit_ship.to_s)
		assert_equal("B4", cell.coordinates)
		assert_equal("miss", cell.miss_ship.to_s)
	end
end