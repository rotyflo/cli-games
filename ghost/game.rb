require "set"
require_relative "player"

class Game
	def initialize(names)
		@players = names.map { |name| Player.new(name.upcase) }
		@player_i = 0
		@fragment = ""
		@dictionary = Set.new(IO.readlines("dictionary.txt", chomp: true))
	end

	def run
		system("clear")
		print "Welcome to Ghost!\n"
		print "Guess one letter at a time.\n"
		print "You will earn 1 letter for each guess that completes a word or doesn't build towards a new word.\n"
		print "You lose if you earn 5 letters, spelling 'GHOST'.\n"
		print "Last one standing wins.\n"

		while !over?
			play_round
		end

		print "\n#{@players[0].name} wins!\n"
	end

	def play_round
		print_score
		take_turn(current_player)
		current_player.lose? ? @players.delete_at(@player_i) : next_player!
	end

	def current_player
		@players[@player_i]
	end

	def previous_player
		@players[@player_i - 1]
	end

	def next_player!
		@player_i = (@player_i + 1) % @players.length
	end

	def print_score
		print "\n#{current_player.name}: #{score(current_player)}\n"
	end

	def take_turn(player)
		guess = current_player.guess.downcase
		@fragment += guess if valid_play?(guess)
		system("clear")
		print "#{current_player.name} has been dropped.\n\n" if current_player.lose?
		print "Word: #{@fragment.upcase}\n"
	end

	def valid_play?(char)
		if "abcdefghijklmnopqrstuvwxyz".include?(char)
			if @dictionary.any? { |word| word.start_with?(@fragment + char) }
				if @dictionary.include?(@fragment + char)
					current_player.alert_invalid_guess
				end
				return true
			end
		end
		
		current_player.alert_invalid_guess
		false
	end

	def score(player)
		player.losses < 0 ? "" : "GHOST"[0..player.losses]
	end

	def over?
		@players.length < 2
	end
end

system("clear")
print "Enter names one by one."
print "\nFinish input process by entering 'end'.\n"
names = []
while names.last != "end"
	print "Player name: "
	names << gets.chomp.downcase
end
names.pop

game = Game.new(names)
game.run
