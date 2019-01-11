require_relative "ship_class.rb"

class Cell

	def initialize(coordinates)
		@coordinates = coordinates
	end

	attr_reader :coordinates
end