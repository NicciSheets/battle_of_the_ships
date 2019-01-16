require "minitest/autorun"
require_relative "cell_class.rb"

class TddCellClass < Minitest::Test

	def test_cell_is_class
		cell = Cell.new("B4")
		# p cell
		assert_equal(Cell, cell.class)
		assert_equal("B4", cell.coordinates)
		assert_equal(:empty, cell.status)
		# assert_equal(0, cell.damage)
	end

	def test_status_is_hit_or_miss
		cell = Cell.new("B4")
		assert_equal(:hit, cell.hit)
		assert_equal(:miss, cell.miss_ship)
	end

	def test_cell_class_returns_as_cell_status_with_to_s
		cell = Cell.new("B4")
		assert_equal("hit", cell.hit.to_s)
		assert_equal("B4", cell.coordinates)
		assert_equal("miss", cell.miss_ship.to_s)
	end

	def test_cell_status_returns_string_to_show_on_board
		cell = Cell.new("B4")
		assert_equal(:empty, cell.status)
		# p cell.cell_status
		assert_equal(".", cell.cell_status)
	end

	def test_place_ship_puts_desired_ship_type_as_status_with_zero_damage
		cell = Cell.new("B4")
		# p cell
		assert_equal(:empty, cell.status)
		assert_equal(".", cell.cell_status)
		assert_equal("B4", cell.coordinates)
		# assert_equal(0, cell.damage)
		cell.place_ship(:cruiser)
		assert_equal(:cruiser, cell.status)
		assert_equal("C", cell.cell_status)
		assert_equal("B4", cell.coordinates)
		# assert_equal(0, cell.damage)
	end

	def test_cell_hit_changes_damage_to_ship
		cell = Cell.new("B4")
		cell.place_ship(:cruiser)
		cell.hit
		assert_equal(:hit, cell.status)
		assert_equal("X", cell.cell_status)
		# assert_equal(1, cell.damage)
	end
end