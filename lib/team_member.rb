class TeamMember
 	def initialize(queue_to_put_completed_work_on, queue_to_take_work_from)
   	@queue_to_put_completed_work_on = queue_to_put_completed_work_on
		@queue_to_take_work_from = queue_to_take_work_from
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
			work_on_item day
			if item_is_completed
				complete_the_item_on day
			end
		end
	end

	def working_on_item
		@current_item != nil
	end

	def work_on_item (day)
		@current_item.do_work_for @roles, day
	end
	
	def item_is_completed
		@current_item.all_work_completed_for @roles	
	end

	def complete_the_item_on (day)
		@queue_to_put_completed_work_on.enq @current_item
		@current_item = nil;
	end

	def pick_up_item_of_work_from_queue
		if @queue_to_take_work_from.has_available_items
			@current_item = @queue_to_take_work_from.deq
		end
	end
end
