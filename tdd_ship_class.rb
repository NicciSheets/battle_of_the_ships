require "minitest/autorun"
require_relative "ship_class.rb"

class TddShipClass < Minitest::Test

	def test_ship_is_a_class
		ship1 = Ship.new(3)
		assert_equal(Ship, ship1.class)
		assert_equal(3, ship1.length)
		assert_equal(0, ship1.damage)
		assert_equal("cruiser", ship1.ship_name)
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

	def test_ship_sunk_if_length_equals_damage
		ship1 = Ship.new(3)
		assert_equal(0, ship1.damage)
		3.times {|hit| ship1.hit}
		assert_equal(true, ship1.sunk?)
		ship2 = Ship.new(4)
		assert_equal(0, ship2.damage)
		# because the length of ship2 is 4, this returns false for whether or not the ship is sunk after being hit 2 times only
		2.times {|hit| ship2.hit}
		assert_equal(false, ship2.sunk?)
		# if ship2 is hit 2 more times, it should return true for it being sunk
		2.times {|hit| ship2.hit}
		assert_equal(true, ship2.sunk?)
	end

	def test_correct_ship_name_returns
		ship1 = Ship.new(2)
		assert_equal("battleship", ship1.ship_name)
		ship2 = Ship.new(3)
		assert_equal("cruiser", ship2.ship_name)
		ship3 = Ship.new(4)
		assert_equal("submarine", ship3.ship_name)
		ship4 = Ship.new(5)
		assert_equal("destroyer", ship4.ship_name)
	end

end
