require 'observer'

class Calendar
	include Observable
	attr_reader :day
	
	def initialize 
		@day = 0
	end

	def move_to_next_day
		@day = @day + 1
		changed true
		notify_observers(@day)
	end
end

