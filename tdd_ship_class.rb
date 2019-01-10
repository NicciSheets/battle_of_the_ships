require "minitest/autorun"
require_relative "ship_class.rb"

class TddShipClass < Minitest::Test

	def test_ship_is_class_returns_name_length_damage
		battleship = Ship.new(:battleship)
		assert_equal(Ship, battleship.class)
		assert_equal(:battleship, battleship.type)
		assert_equal(2, battleship.length)
		assert_equal(0, battleship.damage)
		cruiser = Ship.new(:cruiser)
		assert_equal(Ship, cruiser.class)
		assert_equal(:cruiser, cruiser.type)
		assert_equal(3, cruiser.length)
		assert_equal(0, cruiser.damage)
		submarine = Ship.new(:submarine)
		assert_equal(Ship, submarine.class)
		assert_equal(:submarine, submarine.type)
		assert_equal(4, submarine.length)
		assert_equal(0, submarine.damage)
		destroyer = Ship.new(:destroyer)
		assert_equal(Ship, destroyer.class)
		assert_equal(:destroyer, destroyer.type)
		assert_equal(5, destroyer.length)
		assert_equal(0, destroyer.damage)
	end

	def test_to_s
		battleship = Ship.new(:battleship)
		assert_equal("battleship", battleship.to_s)
		submarine = Ship.new(:submarine)
		assert_equal("submarine", submarine.to_s)
	end

	def test_hit_increases_damage_by_1
		battleship = Ship.new(:battleship)
		assert_equal(0, battleship.damage)
		battleship.hit 
		assert_equal(1, battleship.damage)
		battleship.hit
		# p battleship
		assert_equal(2, battleship.damage)
	end	

end