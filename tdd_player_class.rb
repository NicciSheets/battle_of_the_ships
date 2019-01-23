require "minitest/autorun"
require_relative "board_class.rb"
require_relative "ship_class.rb"
require_relative "cell_class.rb"
require_relative "player_class.rb"

class TddPlayerClass < Minitest::Test

	def test_player_is_class_returns_attributes
		nicci = Player.new("nicci", :beginner)
		assert_equal(Player, nicci.class)
		assert_equal("nicci", nicci.player)
		assert_equal(:beginner, nicci.board.difficulty)
		assert_equal(Board, nicci.board.class)
		assert_equal(:battleship, nicci.battleship.type)
		assert_equal(Ship, nicci.battleship.class)
		assert_equal(:cruiser, nicci.cruiser.type)
		assert_equal(Ship, nicci.cruiser.class)
		assert_equal(:submarine, nicci.submarine.type)
		assert_equal(Ship, nicci.submarine.class)
		assert_equal(:destroyer, nicci.destroyer.type)
		assert_equal(Ship, nicci.destroyer.class)
	end

	def test_to_s
		nicci = Player.new("nicci", :beginner)
		assert_equal("Nicci", nicci.to_s)
	end
end