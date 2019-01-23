require "minitest/autorun"
# require_relative "board_class.rb"
# require_relative "ship_class.rb"
# require_relative "cell_class.rb"
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
		assert_equal(144, nicci.coordinates_to_play.count)
		opponent = Player.new("opponent", :beginner)
		assert_equal(Player, opponent.class)
		assert_equal("opponent", opponent.player)
		assert_equal(:beginner, opponent.board.difficulty)
		assert_equal(Board, opponent.board.class)
		assert_equal(:battleship, opponent.battleship.type)
		assert_equal(Ship, opponent.battleship.class)
		assert_equal(:cruiser, opponent.cruiser.type)
		assert_equal(Ship, opponent.cruiser.class)
		assert_equal(:submarine, opponent.submarine.type)
		assert_equal(Ship, opponent.submarine.class)
		assert_equal(:destroyer, opponent.destroyer.type)
		assert_equal(Ship, opponent.destroyer.class)
		assert_equal(144, opponent.coordinates_to_play.count)
		
	end

	def test_grids_start_out_the_same_with_pretty_printing
		nicci = Player.new("nicci", :beginner)
		opponent = Player.new("opponent", :beginner)
		assert_equal(nicci.pretty_show, opponent.pretty_no_show)
	end

	def test_to_s
		nicci = Player.new("nicci", :beginner)
		assert_equal("Nicci", nicci.to_s)
	end
end