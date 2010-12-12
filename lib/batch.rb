class Batch
	attr_reader :completed_work, :items_to_work_on
	def initialize
		@number_of_items_to_work_on = 0
		@items_to_work_on = []
		@completed_work = []
	end

  def how_many_items_can_be_work_on (number_of_items_able_to_complete)
    number_of_items_completed = 0
    if has_pending_work
      if has_enough_to_work_on_for number_of_items_able_to_complete
        number_of_items_completed = number_of_items_able_to_complete
      else
        number_of_items_completed = length
      end
    end
    return number_of_items_completed
  end

	def deq
		@items_to_work_on.shift
	end

	def enq(item)
		@completed_work << item
	end

	def length
		@items_to_work_on.length
	end

	def is_not_complete 
		@completed_work.length != @number_of_items_to_work_on
	end

	def add_item_to_work_on(item)
		@items_to_work_on << item
		@number_of_items_to_work_on = @number_of_items_to_work_on.next
	end

  private 
  def has_enough_to_work_on_for (number_of_items_able_to_complete)
    @items_to_work_on.length >= number_of_items_able_to_complete
  end

  def has_pending_work
    @items_to_work_on.length > 0
  end
end
