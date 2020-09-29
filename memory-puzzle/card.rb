class Card
	attr_reader :face_val
	def initialize(face_val)
		@face_val = face_val
		@faceup = false
	end
	
	def faceup?
		@faceup
	end

	def display
		@face_val if @faceup
	end

	def hide
		@faceup = false
	end

	def reveal
		@faceup = true
	end
	
	def to_s
		@face_val.to_s
	end

	def ==(card)
		@face_val == card.face_val
	end
end