require "minitest/autorun"
require_relative "ship_class.rb"

class TddShipClass < Minitest::Test

	def test_ship_is_a_class
		ship1 = Ship.new(3)
		assert_equal(Ship, ship1.class)
		assert_equal(3, ship1.length)
		assert_equal(0, ship1.damage)
	end

	def test_adding_damage
		ship1 = Ship.new(3)
		assert_equal(1, ship1.hit)
		assert_equal(1, ship1.damage)
		assert_equal(2, ship1.hit)
		assert_equal(2, ship1.damage)
		assert_equal(3, ship1.hit)
		assert_equal(3, ship1.damage)
		ship2 = Ship.new(2)
		assert_equal(1, ship2.hit)
		assert_equal(1, ship2.damage)
		assert_equal(2, ship2.hit)
		assert_equal(2, ship2.damage)
		# to make sure I can store the hits and access them after performing other operations, printed both out below
		# p "ship1 is #{ship1.damage} and ship2 is #{ship2.damage}"
	end

end
