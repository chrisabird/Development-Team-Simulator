require 'unit_of_work'

class Item
	attr_reader :defined_at
	
	def initialize(defined_at)
		@defined_at = defined_at
		@units_of_work_for = {}
	end

	def completed_at
		unit = @units_of_work_for.values.max {|a,b| a.completed_at <=> b.completed_at}
		unit.completed_at
	end

	def variance
		total = 0
		for unit in @units_of_work_for.values
			total = total + unit.variance
		end
		return total
	end

	def all_work_completed_for (roles)
		for role in roles do
			if !@units_of_work_for[role].is_completed 
				return false
			end
		end
		return true
	end

	def do_work_for (roles, day)
		for role in roles do
			unit_of_work = @units_of_work_for[role]
			if !unit_of_work.is_completed
				unit_of_work.work_on day
				return
			end
		end
	end

	def leadTime
		(completed_at - @defined_at ) + 1
	end

	def add_unit_of_work_for (role_name, unit_of_work)
		@units_of_work_for[role_name] = unit_of_work
	end
end
