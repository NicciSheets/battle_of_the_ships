require "minitest/autorun"
require_relative "cell_class.rb"

class TddCellClass < Minitest::Test

	def test_cell_is_class
		cell = Cell.new("B", "4")
		# p cell
		assert_equal(Cell, cell.class)
		assert_equal("B4", cell.coordinates)
		assert_equal(".", cell.status)
	end

	def test_status_is_hit_or_miss
		cell = Cell.new("B", "4")
		assert_equal("X", cell.hit)
		assert_equal("X", cell.status)
		assert_equal("0", cell.miss)
		assert_equal("0", cell.status)
	end


	def test_place_ship_puts_desired_ship_type_as_status_with_zero_damage
		cell = Cell.new("B", "4")
		cruiser = Ship.new(:cruiser)
		assert_equal(".", cell.status)
		assert_equal("B4", cell.coordinates)
		cell.place_ship(cruiser)
		assert_equal("C", cell.status)
		assert_equal(3, cruiser.length)
		assert_equal(0, cruiser.damage)
		assert_equal("C", cell.render_with_ships)
		assert_equal("B4", cell.coordinates)
	end

	def test_render_with_and_render_without_ships_returns_correctly
		cell = Cell.new("B", "4")
		cruiser = Ship.new(:cruiser)
		cell.place_ship(cruiser)
		assert_equal("C", cell.render_with_ships)
		assert_equal(".", cell.render_without_ships)
	end
end