require_relative "card"

class Board
	attr_reader :grid

	def initialize
		@grid = Array.new(4) { Array.new(4) { nil } }
	end

	def populate
		cards = get_cards.shuffle
		@grid.each do |row|
			row.map! do |card|
				Card.new(cards.pop)
			end
		end
	end

	def get_cards
		cards = ("a".."z").to_a[0...(@grid.length * @grid.length) / 2]
		cards += cards
	end

	def render
		output = "  " + (0...@grid.length).to_a.join(" ") + "\n"
		@grid.each.with_index do |row, i|
			output += i.to_s + " " + row.map do |card|
				card.faceup? ? card : " "
			end.join(" ") + "\n"
		end
		print output
	end

	def won?
		@grid.flatten.all? { |card| card.faceup? }
	end

	def reveal(x, y)
		@grid[x][y].reveal
		@grid[x][y]
	end
end