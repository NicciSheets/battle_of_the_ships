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
		assert_equal(:hit, cell.hit)
		assert_equal(:hit, cell.status)
		assert_equal("X", cell.render_status)
		assert_equal(:miss, cell.miss)
		assert_equal(:miss, cell.status)
		assert_equal("0", cell.render_status)
	end

	def test_render_status_returns_string_to_show_on_board
		cell = Cell.new("B4")
		assert_equal(:empty, cell.status)
		assert_equal(".", cell.render_status)
	end

	def test_place_ship_puts_desired_ship_type_as_status_with_zero_damage
		cell = Cell.new("B4")
		cruiser = Ship.new(:cruiser)
		assert_equal(:empty, cell.status)
		assert_equal(".", cell.render_status)
		assert_equal("B4", cell.coordinates)
		cell.place_ship(cruiser)
		assert_equal(:cruiser, cell.status.type)
		assert_equal(3, cell.status.length)
		assert_equal(0, cell.status.damage)
		assert_equal("C", cell.render_status)
		assert_equal("B4", cell.coordinates)
		# assert_equal(0, cell.damage)
	end

	
end