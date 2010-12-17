class Item
	attr_reader :started_at, :completed_at
	
	def initialize(started_at)
		@started_at = started_at
		@role_estimates = {}
	end

	def complete(day)
		@completed_at = day
	end

	def leadTime
		(@completed_at - @started_at ) + 1
	end

	def add_estimate_for_role (role_name, estimate)
		@role_estimates[role_name] = estimate
	end

	def get_duration_for (role_name)
		if @role_estimates.has_key? role_name
			@role_estimates[role_name]
		else
			0
		end
	end
end
