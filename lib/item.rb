class Item
	attr_reader :started_at, :completed_at
	
	def initialize(started_at)
		@started_at = started_at
	end

	def complete(day)
		@completed_at = day
	end

	def leadTime
		(@completed_at - @started_at ) + 1
	end
end
