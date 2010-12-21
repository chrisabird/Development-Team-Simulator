class UnitOfWork
	def initialize (estimate)
		@estimate = estimate
	end

	def is_completed 
		if @last_worked_on == nil || ((@last_worked_on + 1) - @started_at) != @estimate
			return false
		end
		return true
	end

	def work_on(day)
		if @started_at == nil 
			@started_at = day
		end
		@last_worked_on = day
	end

	def completed_at 
		@last_worked_on
	end
end
