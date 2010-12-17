class TeamMember
 	def initialize(queue_to_put_completed_work_on, queue_to_take_work_from)
   	@queue_to_put_completed_work_on = queue_to_put_completed_work_on
		@queue_to_take_work_from = queue_to_take_work_from
		@time_spent_on_item = 0
		@time_needed_to_complete_item = 0
		@current_item = nil
		@roles = []
 	end

	def update (day)
		do_work_on day
	end

	def listen_to (calendar)
		calendar.add_observer(self)
	end

	def add_role (role_name)
		@roles << role_name
	end

	private
	def do_work_on (day)
		if !working_on_item
			pick_up_item_of_work_from_queue
		end

		if working_on_item
			work_on_item
			if item_is_completed
				complete_the_item_on day
			end
		end
	end

	def working_on_item
		@current_item != nil
	end

	def work_on_item
		@time_spent_on_item = @time_spent_on_item + 1 
	end
	
	def item_is_completed
		@time_needed_to_complete_item == @time_spent_on_item
	end

	def complete_the_item_on (day)
		@current_item.complete day 
		@queue_to_put_completed_work_on.enq @current_item
		@current_item = nil;
		@time_spent_on_item = 0;
	end

	def pick_up_item_of_work_from_queue
		if @queue_to_take_work_from.has_available_items
			@current_item = @queue_to_take_work_from.deq
			@time_needed_to_complete_item = 0
			for role in @roles
				@time_needed_to_complete_item = @time_needed_to_complete_item + @current_item.get_duration_for(role)
			end
		end
	end
end
