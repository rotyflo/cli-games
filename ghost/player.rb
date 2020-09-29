class Player
	attr_accessor :name, :losses

	def initialize(name)
		@name = name
		@losses = -1
	end

	def guess
		print "Choose a letter, #{name}: "
		gets.chomp[0]
	end

	def alert_invalid_guess
		print "You earned a letter!\n"
		sleep(1)
		@losses += 1
	end

	def lose?
		@losses == 4
	end
end