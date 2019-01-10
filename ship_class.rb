class Ship

	SHIP_INFO = {
		:battleship => 2,
		:cruiser    => 3,
		:submarine  => 4,
		:destroyer  => 5
	}

	def initialize(type)
		@type = type
		@length = SHIP_INFO[type]
		@damage = 0
	end

	attr_reader :length, :type, :damage

	# def to_s
	# 	"#{@type}"
	# end
end
