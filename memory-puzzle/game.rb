require_relative "board"

class Game
	def initialize
		@board = Board.new
		@prev_guess = nil
		@flipped_cards = 0
	end

	def play
		@board.populate

		while !over
			system("clear")
			@board.render
			print "Select a position: "
			position = gets.chomp.split("").map(&:to_i)
			guess = @board.reveal(*position)
			@flipped_cards += 1
			if @flipped_cards == 2
				@flipped_cards = 0
				unless guess == @prev_guess
					system("clear")
					@board.render
					sleep(3)
					guess.hide
					@prev_guess.hide
				end
			end
			@prev_guess = guess
		end
	end

	def over
		@board.won?
	end
end

game = Game.new
game.play