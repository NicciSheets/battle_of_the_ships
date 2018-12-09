require_relative "board_class.rb"

class Ship

	attr_reader :length, :damage

	def initialize(length)
		@length = length
		@damage = 0
	end

end
