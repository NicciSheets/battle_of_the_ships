require "minitest/autorun"
require_relative "ship_class.rb"

class TddShipClass < Minitest::Test

	def test_ship_is_a_class
		ship1 = Ship.new(3)
		assert_equal(Ship, ship1.class)
		assert_equal(3, ship1.length)
		assert_equal(0, ship1.damage)
	end

end
