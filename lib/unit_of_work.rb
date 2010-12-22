require 'variance'

class UnitOfWork
	attr_reader :started_at 

	def initialize (estimate)
		@estimate = estimate
	end

	def is_completed 
		!(not_started || not_yet_completed)
	end

	def variance
		get_duration - @estimate
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

	private
	def not_started
		@last_worked_on == nil
	end

	def not_yet_completed
		days_left_to_be_completed != get_duration
	end
	
	def days_left_to_be_completed
		((@last_worked_on + 1) - @started_at)
	end

	def get_duration
		if @duration == nil
			@duration = Variance.new.calculate(@estimate)
		end
		@duration
	end
end
