require_relative "board_class.rb"

class Ship

	attr_reader :length, :damage

	def initialize(length)
		@length = length
		@damage = 0
	end

	def hit
		@damage +=1
	end

	def sunk?
		@length == @damage
	end

end
