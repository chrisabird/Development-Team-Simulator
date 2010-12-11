class TeamMember
 	def initialize(queue_to_put_completed_work_on, number_of_items_able_to_complete = 1, queue_to_take_work_from = nil)
   	@queue_to_put_completed_work_on = queue_to_put_completed_work_on
		@number_of_items_able_to_complete = number_of_items_able_to_complete
		@queue_to_take_work_from = queue_to_take_work_from
 	end

	def update (day_of_month)
		do_work day_of_month
	end

	def listen_to (calendar)
		calendar.add_observer(self)
	end

	private
	def do_work (day_of_month)
		if being_fed_from_queue
			complete_some_of_the_available_work day_of_month
		else
			create_work day_of_month
		end
	end

	def being_fed_from_queue
		@queue_to_take_work_from != nil
	end

	def complete_some_of_the_available_work(day)
		items = @queue_to_take_work_from.how_many_items_can_be_work_on @number_of_items_able_to_complete
		for i in 1..items 
			item = @queue_to_take_work_from.deq
			item.complete day
			@queue_to_put_completed_work_on.enq item
		end
	end

	def create_work(day)
		for i in 1..@number_of_items_able_to_complete
			@queue_to_put_completed_work_on.enq Item.new(day)
		end
	end
end
