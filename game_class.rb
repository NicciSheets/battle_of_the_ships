require_relative "player_class.rb"

class Game

	attr_reader :player, :opponent

	def set_difficulty
		difficulty = ""
		if difficulty.empty?
			print "Please choose a difficulty level: (b)Beginner; (i)Intermediate; (a)Advanced: "
			difficulty = gets.chomp
			if difficulty == ""
				print "Please choose a valid difficulty level: (b)Beginner; (i)Intermediate; (a)Advanced: "
				difficulty = gets.chomp
				if difficulty.downcase == "b" || difficulty.downcase == "beginner"
					@game_difficulty = :beginner
				elsif difficulty.downcase == "i" || difficulty.downcase == "intermediate"
					@game_difficulty = :intermediate
				else difficulty.downcase == "a" || difficulty.downcase == "advanced"
					@game_difficulty = :advanced
				end
			else
				if difficulty.downcase == "b" || difficulty.downcase == "beginner"
					@game_difficulty = :beginner
				elsif difficulty.downcase == "i" || difficulty.downcase == "intermediate"
					@game_difficulty = :intermediate
				else difficulty.downcase == "a" || difficulty.downcase == "advanced"
					@game_difficulty = :advanced
				end
			end
		end
	end
				

	def set_player
		player = ""
		if player.empty?
			print "Player 1: Please enter your name: "
			player = gets.chomp
			if player == ""
				print "Player 1: Please enter a valid name: "
				player = gets.chomp
			end
			difficulty = @game_difficulty
			@player = Player.new(player, difficulty)
		end
	end


	def create_opponent
		difficulty = @game_difficulty
		@opponent = Player.new("opponent", difficulty)
	end

	 

end

p game = Game.new()
game.set_difficulty
game.set_player
game.create_opponent
game.player.pretty_show
game.opponent.pretty_no_show